# Wekelijkse routine: notulen-concept dinsdag 10:00

Nog niet actief. De geplande taak kon niet vanuit de sessie worden aangemaakt
(planner-service onbereikbaar); zet hem handmatig aan in Cowork via
"Scheduled tasks" / "Geplande taken", of vraag Claude het opnieuw te proberen.

## Instellingen

- **Schema**: elke dinsdag 10:00 Nederlandse tijd (cron `0 8 * * 2` in UTC bij
  zomertijd; in de wintertijd wordt dit `0 9 * * 2`)
- **Sessie**: nieuwe sessie per run, in de omgeving met deze repo
- **Connectors**: Microsoft 365 en Composio
- **Notificatie**: push bij afronding

## Prompt voor de taak

```
Genereer de notulen van de wekelijkse De Goos vergadering en zet het
Outlook-concept klaar. De repo De-Goos-Notulen staat uitgecheckt in de
werkdirectory; lees eerst CLAUDE.md en volg daarna de skill
.claude/skills/notulen-de-goos/SKILL.md stap voor stap.

Kern:
1. Zoek de De Goos vergadering van de afgelopen zeven dagen (meestal gisteren,
   maandag). Geen vergadering gevonden: stoppen en David pingen, verder niets doen.
2. Haal het transcript op (route A SharePoint, route B Graph via
   meetingTranscriptUrl). Geen transcript: stoppen, niets schrijven.
3. Rol het Lopend overzicht door vanaf de meest recente archief/JJJJ-MM-DD-notulen.md.
4. Genereer de docx met python-docx (niet met docx-js; dat gaf eerder een bestand
   dat Word op iOS weigert). Valideer de docx voordat hij als bijlage wordt gebruikt.
5. Maak het Outlook-concept via Composio (OUTLOOK_CREATE_DRAFT +
   OUTLOOK_ADD_MAIL_ATTACHMENT). Alleen een concept, nooit versturen.
6. Voeg de meest recente "Investeringsbegroting De Goos" xlsx uit SharePoint toe
   als tweede bijlage (site MosselGin, map "Mossel en Gin BV/De Goos/Verbouwing/
   Begroting"). Downloaden gaat via de Composio one_drive-koppeling (account
   david@mosselengin.nl); de Outlook-koppeling zelf heeft geen bestandsrechten.
   Lukt het niet, sla de stap over en meld het in de ping.
7. Schrijf de WhatsApp-samenvatting weg als bestand, verstuur niets via WhatsApp.
8. Commit en push de nieuwe archiefbestanden naar branch
   claude/de-goos-notulen-setup-42loej.
9. Sluit af met de ping aan David volgens stap 9 van de skill en stop daarna.
   Wachten op akkoord; niets versturen.
```
