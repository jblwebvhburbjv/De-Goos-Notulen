#!/usr/bin/env bash
#
# Post een bericht naar de lokale Baileys bridge van De Goos.
#
# Gebruik:
#   scripts/send_whatsapp.sh <bericht>            [endpoint] [jid]
#   scripts/send_whatsapp.sh -f <pad-naar-bestand> [endpoint] [jid]
#
# Endpoint en JID komen uit de omgevingsvariabelen WHATSAPP_BRIDGE_URL en
# WHATSAPP_GROUP_JID. Zijn die leeg of niet gezet, dan vallen ze terug op
# argument 2 en argument 3.
#
# Het script faalt hard als de bridge niet bereikbaar is of een foutstatus
# teruggeeft. Er wordt niets stil overgeslagen.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname -- "$SCRIPT_DIR")"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/whatsapp.log"

die() {
  printf 'FOUT: %s\n' "$1" >&2
  exit "${2:-1}"
}

usage() {
  sed -n '3,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//' >&2
  exit 64
}

[ "$#" -ge 1 ] || usage

# --- bericht inlezen ---------------------------------------------------------

if [ "$1" = "-f" ]; then
  [ "$#" -ge 2 ] || die "optie -f verwacht een pad naar een bestand"
  MESSAGE_FILE="$2"
  [ -f "$MESSAGE_FILE" ] || die "berichtbestand bestaat niet: $MESSAGE_FILE"
  [ -r "$MESSAGE_FILE" ] || die "berichtbestand is niet leesbaar: $MESSAGE_FILE"
  MESSAGE="$(cat -- "$MESSAGE_FILE")"
  shift 2
else
  MESSAGE="$1"
  shift 1
fi

[ -n "${MESSAGE//[[:space:]]/}" ] || die "het bericht is leeg, er wordt niets verstuurd"

# --- endpoint en jid: omgeving eerst, argumenten als fallback ----------------

ENDPOINT="${WHATSAPP_BRIDGE_URL:-}"
[ -n "$ENDPOINT" ] || ENDPOINT="${1:-}"

JID="${WHATSAPP_GROUP_JID:-}"
[ -n "$JID" ] || JID="${2:-}"

if [ -z "$ENDPOINT" ]; then
  die "geen endpoint. Zet WHATSAPP_BRIDGE_URL of geef het als tweede argument mee, bijvoorbeeld http://localhost:3000/send"
fi

if [ -z "$JID" ]; then
  die "geen groep-JID. Zet WHATSAPP_GROUP_JID of geef het als derde argument mee, bijvoorbeeld 1203630000000000000@g.us"
fi

case "$ENDPOINT" in
  http://*|https://*) ;;
  *) die "endpoint moet met http:// of https:// beginnen, kreeg: $ENDPOINT" ;;
esac

case "$JID" in
  *@g.us|*@s.whatsapp.net) ;;
  *) die "JID ziet er niet uit als een WhatsApp-JID (verwacht ...@g.us of ...@s.whatsapp.net), kreeg: $JID" ;;
esac

command -v curl >/dev/null 2>&1 || die "curl is niet geinstalleerd"

# --- JSON opbouwen -----------------------------------------------------------

build_payload() {
  if command -v jq >/dev/null 2>&1; then
    jq -nc --arg jid "$JID" --arg message "$MESSAGE" '{jid: $jid, message: $message}'
  elif command -v python3 >/dev/null 2>&1; then
    JID="$JID" MESSAGE="$MESSAGE" python3 -c \
      'import json, os; print(json.dumps({"jid": os.environ["JID"], "message": os.environ["MESSAGE"]}))'
  else
    die "geen jq en geen python3 gevonden, kan de JSON niet veilig opbouwen"
  fi
}

PAYLOAD="$(build_payload)"

# --- versturen ---------------------------------------------------------------

mkdir -p "$LOG_DIR"

RESPONSE_BODY="$(mktemp)"
trap 'rm -f "$RESPONSE_BODY"' EXIT

set +e
HTTP_CODE="$(
  curl --silent --show-error \
       --connect-timeout 5 \
       --max-time 30 \
       --output "$RESPONSE_BODY" \
       --write-out '%{http_code}' \
       --request POST \
       --header 'Content-Type: application/json' \
       ${WHATSAPP_BRIDGE_TOKEN:+--header "Authorization: Bearer $WHATSAPP_BRIDGE_TOKEN"} \
       --data "$PAYLOAD" \
       "$ENDPOINT" 2>"$RESPONSE_BODY.err"
)"
CURL_STATUS=$?
set -e

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

if [ "$CURL_STATUS" -ne 0 ]; then
  CURL_ERR="$(cat "$RESPONSE_BODY.err" 2>/dev/null || true)"
  rm -f "$RESPONSE_BODY.err"
  printf '%s\tONBEREIKBAAR\t%s\tcurl=%s\t%s\n' \
    "$TIMESTAMP" "$ENDPOINT" "$CURL_STATUS" "$CURL_ERR" >>"$LOG_FILE"
  die "de Baileys bridge op $ENDPOINT is niet bereikbaar (curl exitcode $CURL_STATUS). ${CURL_ERR:-Draait de bridge en klopt het endpoint?} Er is niets verstuurd." 2
fi

rm -f "$RESPONSE_BODY.err"

if [ "$HTTP_CODE" -lt 200 ] || [ "$HTTP_CODE" -ge 300 ]; then
  BODY="$(head -c 500 "$RESPONSE_BODY")"
  printf '%s\tHTTP_%s\t%s\t%s\n' "$TIMESTAMP" "$HTTP_CODE" "$ENDPOINT" "$BODY" >>"$LOG_FILE"
  die "de bridge gaf HTTP $HTTP_CODE terug. Antwoord: ${BODY:-<leeg>}. Er is niets verstuurd." 3
fi

printf '%s\tOK\t%s\t%s\t%s tekens\n' \
  "$TIMESTAMP" "$ENDPOINT" "$JID" "${#MESSAGE}" >>"$LOG_FILE"

printf 'Verstuurd naar %s via %s (HTTP %s)\n' "$JID" "$ENDPOINT" "$HTTP_CODE"
