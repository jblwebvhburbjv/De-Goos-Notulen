---
name: notulen-de-goos
description: Genereert de notulen van de wekelijkse De Goos vergadering uit het Teams-transcript als docx-bijlage, rolt het lopende actieoverzicht door, en zet een concept klaar in Outlook. Gebruik deze skill wanneer David vraagt om de notulen van deze week, de notulen van de vergadering, de notulen van De Goos, een verslag of samenvatting van het De Goos overleg, of vraagt om de notulen te maken, bij te werken of klaar te zetten. Triggert ook op "notulen", "verslag vergadering", "De Goos meeting", "notulen deze week", "openstaande acties De Goos" en "wat is er besloten in de vergadering".
---

# Notulen De Goos

Genereert de notulen van de wekelijkse De Goos vergadering uit het Teams-transcript, rolt het
cumulatieve actieoverzicht door, levert een docx-bijlage op en zet een concept klaar in
Outlook. Verstuurt nooit iets.

Lees eerst `CLAUDE.md` in de projectroot. Daar staan de deelnemers, de ontvangers, het
volledige notulenformat, de doorrol-logica, de toon, de uitsluitingslijst en de harde regels.
Die gelden boven alles wat hieronder staat.

De notulen zijn een **docx-bijlage**, niet de mailbody. Er is **geen vaste agenda**: de
onderwerpen volgen de vergadering van die week.

## Stap 1 - vergadering zoeken

Zoek via de Microsoft 365 MCP in de agenda van David naar de De Goos vergadering van de
afgelopen zeven dagen.

- `outlook_calendar_search` met query `Goos`, `afterDateTime` zeven dagen geleden,
  `beforeDateTime` vandaag.
- De terugkerende afspraak heet "Meeting | De Goos", organisator david@mosselengin.nl.
- Meerdere treffers: neem de meest recente die al geweest is. Een afspraak die nog moet
  plaatsvinden telt niet.

Noteer vergaderdatum, starttijd en duur; die gaan in de kop van het document.

Niets gevonden is stoppen. Ping David dat er geen vergadering in de afgelopen zeven dagen
staat en doe verder niets.

## Stap 2 - transcript ophalen

**Route A, eerst proberen.** Zoek het transcript als bestand.

- `sharepoint_search` en `sharepoint_folder_search` op de mappen `Opnamen` en `Recordings`
  van de organisator, in OneDrive en SharePoint. Teams dumpt het transcript daar als `.vtt`
  of `.docx`.
- Filter op de vergaderdatum uit stap 1. Zoektermen: `Goos`, `Meeting`, de datum.
- Gevonden: lees het bestand met `read_resource` op de teruggegeven `file:///` URI.
- Let op: de map bevat vaak alleen `.mp4`-opnames. Een opname is geen transcript. Ga dan
  door naar route B.

**Route B, alleen als route A niets oplevert.** Haal het transcript via de Graph API.

- Lees de agenda-afspraak met `read_resource` op de `calendar:///events/{id}` URI uit stap 1.
- Neem het veld `meetingTranscriptUrl` letterlijk over en lees dat met `read_resource`
  (`meeting-transcript:///events/{joinUrlToken}`). Scope de terugkerende reeks met `start`
  en `end` op de vergaderdatum, anders krijg je het transcript van een andere week.
- Deze route vereist admin-consent op de transcript-permissies. Faalt hij met een permissie-
  of consent-fout, meld dat aan David en stop. Niet omzeilen, geen andere bron aanboren,
  geen notulen schrijven uit de agenda of de mail.

Geen transcript via beide routes is stoppen. Niets schrijven, niets versturen.

Onthoud welke route gebruikt is; dat moet in de ping van stap 9.

**Lees het transcript volledig** voordat je begint met schrijven. Bij een groot transcript:
sla het op en lees het in chunks tot 100 procent gelezen is. Nooit samenvatten op basis van
een deel.

Let op de sprekerlabels. Teams zet deelnemers die vanaf één apparaat meepraten onder één
label. Zie je dat iemand bij naam wordt aangesproken en er antwoordt een ander label, ga dan
niet gokken wie wat zei: zet de eigenaar op `(eigenaar tbd)` en meld het in de ping.

## Stap 3 - vorige notulen ophalen

Nodig voor de doorrol. Doe dit voordat je begint met schrijven.

1. Kijk eerst lokaal in `archief/` naar de meest recente `JJJJ-MM-DD-notulen.md`. Lees
   daaruit sectie 4, het Lopend overzicht.
2. Staat daar niets, zoek dan in Outlook naar de laatst verstuurde notulen:
   `outlook_email_search` met query `Notulen De Goos`, folder `Sent Items`, gesorteerd op
   nieuwste. Lees de docx-bijlage en haal daar het Lopend overzicht uit.
3. Is er noch lokaal noch in Outlook een voorganger, dan is dit de eerste run: het Lopend
   overzicht begint leeg en bestaat alleen uit de nieuwe acties van deze vergadering. Meld
   dat expliciet in de ping.

Neem het gevonden Lopend overzicht letterlijk over als startpunt. Niet herschrijven, niet
opnieuw indelen, nog niets weggooien.

## Stap 4 - notulen schrijven

Schrijf volgens `templates/notulen-template.md` en het format in `CLAUDE.md`.

**Kop.** Vergaderdatum, starttijd en duur uit stap 1. Aanwezigheid uit het **transcript**,
niet uit de agenda-uitnodiging. Voornamen, met context waar het transcript die geeft, zoals
"Sam (vanuit Frankrijk)". Notulist is altijd "David (op basis van transcript)".

**Sectie 1 Samenvatting.** Eén lopend tekstblok van 150 tot 250 woorden. Geen bullets, geen
kopjes. Kernbesluiten, financiële knelpunten en belangrijkste voortgang, verteld aan iemand
die er niet bij was. Concrete bedragen en namen, binnen de grenzen van de uitsluitingslijst.

**Sectie 2 Onderwerpen.** Genummerd, meestal 5 tot 9. Titels volgen de vergadering van die
week: notaris, elektra, personeel, branding, kunst, inrichting, wat er speelde. Geen vaste
agenda, geen lege verplichte kopjes. Per onderwerp wat besproken en besloten is. Besluiten
markeren met `Besluit:`. Bedragen letterlijk overnemen, inclusief incl/ex btw waar genoemd.

**Sectie 3 To-do's uit deze vergadering.** Alleen de nieuwe acties. Alle vijf categorieën
altijd tonen, in vaste volgorde, ook een lege categorie: dan de kop zonder regels eronder.
Formaat `Actie (Eigenaar)` of `Actie (Eigenaar – deadline)`.

**Sectie 4 Lopend overzicht.** Pas hier de doorrol-logica uit `CLAUDE.md` toe op het
overzicht uit stap 3:

- Actie is klaar volgens het transcript: **verwijderen**, niet doorstrepen.
- Actie is genoemd met voortgang maar niet klaar: status `loopt`, formulering aanscherpen
  naar de actuele stand.
- Actie is niet genoemd: laten staan zoals hij was.
- Nieuwe acties uit sectie 3 toevoegen aan de juiste categorie.
- Dubbelingen samenvoegen tot één regel. Vage regels concreet maken waar het transcript dat
  toelaat, anders laten staan.
- "Wekelijks overleg" en "Lopend overzicht bijhouden (David)" krijgen status `doorlopend` en
  blijven staan.
- Twijfel of iets af is: **niet verwijderen**, status laten staan, en de twijfel opsparen
  voor de ping onder "twijfelpunten doorrol".

Houd tijdens het doorrollen een lijstje bij van wat je verwijderd hebt en waarom. Dat gaat
mee in de ping.

**Controleer de uitsluitingslijst uit `CLAUDE.md` voordat je verder gaat.** Loop het concept
regel voor regel na. Alles wat eronder valt gaat eruit, ook uit de samenvatting. Houd bij wat
je hebt weggelaten en waarom. Bij twijfel weglaten.

## Stap 5 - kwaliteitscheck

Doe deze check voordat je de docx genereert. Faalt een punt, herstel het en check opnieuw.

- Alle vijf categorieën aanwezig in sectie 3 en in sectie 4, ook de lege.
- Geen actie uit het vorige Lopend overzicht stilletjes verdwenen zonder dat het transcript
  de afronding bevestigt. Vergelijk regel voor regel met het overzicht uit stap 3.
- Samenvatting is lopende tekst van 150 tot 250 woorden, geen bullets.
- Bestandsnaam klopt met de vergaderdatum, niet met vandaag.
- Elk bedrag in sectie 2 is letterlijk terug te vinden in het transcript.
- Elke regel in sectie 3 en 4 heeft een eigenaar, of expliciet `(eigenaar tbd)`.
- De inleidende regel van sectie 4 staat er, met de juiste datum.

## Stap 6 - docx genereren en archiveren

Gebruik de `docx` skill. Normale zakelijke opmaak: vetgedrukte sectiekoppen, verder platte
tekst. Geen kleuren, geen logo, geen opsmuk.

Sla op als `archief/JJJJ-MM-DD Notulen De Goos.docx`, met de vergaderdatum.

Sla daarnaast de markdown-versie op als `archief/JJJJ-MM-DD-notulen.md`. Dit is niet
optioneel: de volgende run leest daaruit het Lopend overzicht voor de doorrol.

Past David het concept later nog aan voordat hij verstuurt, dan moeten beide bestanden in
`archief/` worden bijgewerkt. Meld dat in de ping.

## Stap 7 - Outlook concept

Maak een concept in Outlook via de Composio MCP. **Alleen een concept, geen verzending.**

- Zoek de juiste tool met `COMPOSIO_SEARCH_TOOLS` (use_case: een e-mailconcept met bijlage
  aanmaken in Outlook). Gebruik het teruggegeven tool-slug; verzin geen slugs.
- Afzender: david@mosselengin.nl
- Ontvangers: de vijf adressen uit `CLAUDE.md`, inclusief David zelf.
- Onderwerp: `Notulen [d-m]` of `Notulen [d-m] | De Goos`, met de vergaderdatum.
- Body, minimaal en letterlijk:

```
Hoihoi,

Hierbij de notulen.

Groet,
David
```

- Bijlage: de docx uit stap 6.

Ondersteunt de beschikbare concepttool geen bijlagen, dan **stop je**. Meld dat aan David.
Zet de notulen niet in de mailbody als noodoplossing; het format schrijft een bijlage voor.
Gebruik geen enkele tool die direct verstuurt. Is alleen een verzendtool beschikbaar, stop
en meld dat.

## Stap 8 - WhatsApp samenvatting

Schrijf een korte samenvatting van maximaal zes regels naar
`archief/JJJJ-MM-DD-whatsapp.txt`. Zelfde toon als de begeleidende mail.

**Niet versturen.** WhatsApp is nog niet geconfigureerd: de groep-JID en het bridge-endpoint
ontbreken in `CLAUDE.md`. Schrijf het bestand, roep `scripts/send_whatsapp.sh` niet aan.

## Stap 9 - ping David

Meld in één bericht:

- pad naar het Outlook-concept, de docx en de markdown-versie
- aantal nieuwe acties in sectie 3, en hoeveel daarvan een `(eigenaar tbd)` hebben
- doorrol: hoeveel regels verwijderd (met welke, en waarom je denkt dat ze af zijn), hoeveel
  op `loopt` gezet, hoeveel ongewijzigd blijven staan, hoeveel toegevoegd
- **twijfelpunten doorrol**: regels waarvan onduidelijk is of ze af zijn, die je daarom hebt
  laten staan
- welke twijfelpunten je hebt weggelaten op grond van de uitsluitingslijst
- of route A of route B gebruikt is voor het transcript
- of het vorige overzicht uit `archief/` of uit Outlook kwam, of dat dit de eerste run was

Daarna stoppen. Niets versturen, niet doorwerken, wachten op akkoord van David.

## Stoppunten samengevat

Stop en meld, zonder iets te versturen, bij:

- geen De Goos vergadering in de afgelopen zeven dagen
- geen transcript via route A en route B
- route B faalt op ontbrekende admin-consent
- de concepttool ondersteunt geen bijlagen
- alleen een verzendtool beschikbaar in plaats van een concepttool
