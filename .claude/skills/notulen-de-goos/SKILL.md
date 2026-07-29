---
name: notulen-de-goos
description: Genereert de notulen van de wekelijkse De Goos vergadering uit het Teams-transcript en zet een concept klaar in Outlook. Gebruik deze skill wanneer David vraagt om de notulen van deze week, de notulen van de vergadering, de notulen van De Goos, een verslag of samenvatting van het De Goos overleg, of vraagt om de notulen te maken, bij te werken of klaar te zetten. Triggert ook op "notulen", "verslag vergadering", "De Goos meeting", "notulen deze week" en "wat is er besloten in de vergadering".
---

# Notulen De Goos

Genereert de notulen van de wekelijkse De Goos vergadering uit het Teams-transcript,
slaat ze op in het archief, en zet een concept klaar in Outlook. Verstuurt nooit iets.

Lees eerst `CLAUDE.md` in de projectroot. Daar staan de deelnemers, de vaste agendapunten,
de toon, de uitsluitingslijst en de harde regels. Die gelden boven alles wat hieronder staat.

## Stap 1 - vergadering zoeken

Zoek via de Microsoft 365 MCP in de agenda van David naar de De Goos vergadering van de
afgelopen zeven dagen.

- `outlook_calendar_search` met query `Goos`, `afterDateTime` zeven dagen geleden,
  `beforeDateTime` vandaag.
- De terugkerende afspraak heet "Meeting | De Goos", organisator david@mosselengin.nl.
- Meerdere treffers: neem de meest recente die al geweest is. Een afspraak die nog moet
  plaatsvinden telt niet.

Niets gevonden is stoppen. Ping David dat er geen vergadering in de afgelopen zeven dagen
staat en doe verder niets.

## Stap 2 - transcript ophalen

**Route A, eerst proberen.** Zoek het transcript als bestand.

- `sharepoint_search` en `sharepoint_folder_search` op de mappen `Opnamen` en `Recordings`
  van de organisator, in OneDrive en SharePoint. Teams dumpt het transcript daar als `.vtt`
  of `.docx`.
- Filter op de vergaderdatum uit stap 1. Zoektermen: `Goos`, `Meeting`, de datum.
- Gevonden: lees het bestand met `read_resource` op de teruggegeven `file:///` URI.

**Route B, alleen als route A niets oplevert.** Haal het transcript via de Graph API.

- Lees de agenda-afspraak met `read_resource` op de `calendar:///events/{id}` URI uit stap 1.
- Neem het veld `meetingTranscriptUrl` letterlijk over en lees dat met `read_resource`
  (`meeting-transcript:///events/{joinUrlToken}`). Scope de terugkerende reeks met `start`
  en `end` op de vergaderdatum.
- Deze route vereist admin-consent op de transcript-permissies. Faalt hij met een
  permissie- of consent-fout, meld dat aan David en stop. Niet omzeilen, geen andere bron
  aanboren, geen notulen schrijven uit de agenda of de mail.

Geen transcript via beide routes is stoppen. Niets schrijven, niets versturen.

Onthoud welke route gebruikt is. Dat moet in de ping van stap 6.

## Stap 3 - notulen schrijven

Schrijf de notulen volgens `templates/notulen-template.md`.

- Alle zeven vaste agendapunten uit `CLAUDE.md`, in die volgorde, ook de niet besproken
  punten. Niet besproken krijgt exact de regel `Niet besproken.`
- Per agendapunt wat besloten is, niet wat gezegd is. Geen discussieweergave.
- Elk actiepunt krijgt een eigenaar en een deadline. Ontbreekt een van beide in het
  transcript, dan letterlijk `tbd`. Niets invullen wat aannemelijk lijkt.
- Bedragen en datums letterlijk overnemen uit het transcript. Niet afronden, niet omrekenen,
  niet interpoleren.
- Toon: zakelijk en kort, alleen feiten, besluiten en actiepunten.

**Controleer de uitsluitingslijst uit `CLAUDE.md` voordat je opslaat.** Loop de conceptnotulen
regel voor regel na. Alles wat onder de uitsluitingslijst valt gaat eruit. Houd bij wat je
hebt weggelaten en waarom; dat gaat mee in de ping van stap 6. Bij twijfel weglaten.

Sla op als `archief/JJJJ-MM-DD-notulen.md`, met de vergaderdatum in de bestandsnaam.

## Stap 4 - Outlook concept

Maak een concept in Outlook via de Composio MCP. **Alleen een concept, geen verzending.**

- Zoek de juiste tool met `COMPOSIO_SEARCH_TOOLS` (use_case: een e-mailconcept aanmaken in
  Outlook). Gebruik het teruggegeven tool-slug; verzin geen slugs.
- Afzender: david@mosselengin.nl
- Ontvangers: de deelnemers uit `CLAUDE.md`, behalve David zelf.
- Onderwerp: `Notulen De Goos - {datum}`
- Body: korte informele begeleidende tekst die begint met "Hoihoi,", daaronder de notulen.
  Geen gedachtestreepjes, geen vetgedrukte tekst, geen emoji.
- Gebruik geen enkele tool die direct verstuurt. Als alleen een verzendtool beschikbaar is,
  stop en meld dat.

## Stap 5 - WhatsApp samenvatting

Schrijf een korte samenvatting van maximaal zes regels naar
`archief/JJJJ-MM-DD-whatsapp.txt`. Zelfde toon als de begeleidende mail.

**Niet versturen.** WhatsApp is nog niet geconfigureerd: de groep-JID en het bridge-endpoint
ontbreken in `CLAUDE.md`. Schrijf het bestand, roep `scripts/send_whatsapp.sh` niet aan.
Zodra David de JID en het endpoint aanlevert, kan die stap er los achteraan.

## Stap 6 - ping David

Meld in één bericht:

- pad naar het Outlook-concept en het pad naar het notulenbestand
- aantal actiepunten, en hoeveel daarvan een `tbd` hebben
- welke twijfelpunten je hebt weggelaten op grond van de uitsluitingslijst
- of route A of route B gebruikt is voor het transcript

Daarna stoppen. Niets versturen, niet doorwerken, wachten op akkoord van David.

## Stoppunten samengevat

Stop en meld, zonder iets te versturen, bij:

- geen De Goos vergadering in de afgelopen zeven dagen
- geen transcript via route A en route B
- route B faalt op ontbrekende admin-consent
- alleen een verzendtool beschikbaar in plaats van een concepttool
