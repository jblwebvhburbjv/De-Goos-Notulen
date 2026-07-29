# De Goos - notulen automatisering

## Bedrijfscontext

De Goos BV exploiteert Eetcafe De Goos, Gosschalklaan 12, Westergasterrein Amsterdam.
Het bedrijf komt voort uit een rebranding vanuit Mossel & Gin.

Afzender van alle notulen en begeleidende mail: david@mosselengin.nl

## Vaste deelnemers

| Naam | E-mail | Rol |
| --- | --- | --- |
| David André | david@mosselengin.nl | organisator vergadering, notulist, afzender |
| Sam Verheij | samverheij@gmail.com | tbd |
| Arno Hendriks | arnohendrikschef@gmail.com | tbd |
| Gabi Hendriks | gabrielbhendriks@gmail.com | tbd |
| Wouter ten Velde | wouter@mosselengin.nl | tbd |

Deze adressen zijn afgeleid uit de deelnemerslijst van de terugkerende Outlook-afspraak
"Meeting | De Goos" (organisator david@mosselengin.nl). De rollen zijn nog niet bevestigd
door David en staan daarom op tbd. Vul ze aan zodra ze bekend zijn, verzin ze niet.

### Ontvangers van het Outlook-concept

Alle vijf, inclusief David zelf:

```
gabrielbhendriks@gmail.com
arnohendrikschef@gmail.com
samverheij@gmail.com
wouter@mosselengin.nl
david@mosselengin.nl
```

## Het notulenformat

**De notulen zijn een DOCX-bijlage bij de mail, niet de mailbody.**

Bestandsnaam: `JJJJ-MM-DD Notulen De Goos.docx`, met de datum van de **vergadering**,
niet de verzenddatum.

Opmaak: normale zakelijke opmaak. Vetgedrukte sectiekoppen, verder platte tekst.

### Kop van het document

```
JJJJ-MM-DD Notulen De Goos
Datum: [voluit, bv. 20 juli 2026]
Tijd: [starttijd] uur (duur ca. [duur])
Aanwezig: [voornamen, met context waar relevant, bv. "Sam (vanuit Frankrijk)" of
"David (online vanuit Spanje)"]
Notulist: David (op basis van transcript)
```

### Daarna exact vier secties, in deze volgorde

**1. Samenvatting**
Eén lopend tekstblok van ongeveer 150 tot 250 woorden. Geen bullets. Vat de kernbesluiten,
financiële knelpunten en belangrijkste voortgang samen alsof je het vertelt aan iemand die
er niet bij was. Concrete bedragen en namen erin.

**2. Onderwerpen**
Genummerde secties, meestal 5 tot 9, met titels die de vergadering van die week volgen.
**Er is geen vaste agenda.** De onderwerpen variëren per week: notaris, elektra, personeel,
branding, kunst, inrichting, wat er die week speelde. Per onderwerp korte alinea's of losse
regels met wat besproken en besloten is. Besluiten expliciet markeren met `Besluit:`.
Bedragen letterlijk uit het transcript, inclusief incl/ex btw waar dat genoemd wordt.

**3. To-do's uit deze vergadering**
Alleen de **nieuwe** acties uit deze vergadering, gegroepeerd onder exact deze vijf
categorieën, altijd alle vijf, in deze volgorde:

1. Financieel & Juridisch
2. Personeel
3. Materiaal & Inrichting
4. Marketing, PR & Branding
5. Operatie & Werkritme

Formaat per regel: `[Actie] ([Eigenaar])`, of met deadline `[Actie] ([Eigenaar] – morgen)`.

**4. Lopend overzicht – openstaande acties**
Het cumulatieve actieoverzicht dat elke week wordt doorgerold en opgeschoond. Begint altijd
met deze regel:

```
Cumulatieve stand per [datum]. Alleen nog openstaande punten; afgeronde acties zijn
verwijderd. Status = open / loopt / doorlopend.
```

Dezelfde vijf categorieën, in dezelfde volgorde. Formaat per regel:
`[Actie] – [status] ([Eigenaar])`, waarbij status `open`, `loopt` of `doorlopend` is.

## De doorrol-logica

Dit is de kern van de skill. Elke run, in deze volgorde:

1. **Haal de vorige notulen op.** Eerst uit `archief/` lokaal. Staat daar niets, zoek dan de
   laatst verstuurde "Notulen De Goos" docx in Outlook (verzonden items) en lees het
   Lopend overzicht daaruit.
2. **Neem het vorige Lopend overzicht als startpunt.**
3. **Werk het bij aan de hand van het nieuwe transcript:**
   - Actie is klaar volgens het transcript: **verwijderen**. Niet doorstrepen, niet als
     "afgerond" markeren, gewoon weg. Het overzicht bevat alleen openstaande punten.
   - Actie is genoemd met voortgang maar niet klaar: status naar `loopt`, en de formulering
     waar nodig aanscherpen naar de actuele stand (bedrag of aanpak gewijzigd).
   - Actie is niet genoemd: laten staan zoals hij was.
   - Nieuwe acties uit sectie 3: toevoegen aan de juiste categorie.
4. **Opschonen bij het doorrollen:**
   - Dubbelingen samenvoegen; dezelfde actie in andere woorden wordt één regel.
   - Vage regels concreet maken als het transcript dat toelaat, anders laten staan.
   - Elke regel heeft een eigenaar. Ontbreekt die en geeft het transcript geen uitsluitsel,
     zet dan `(eigenaar tbd)` en meld het in de ping.
   - Terugkerende zaken zoals "Wekelijks overleg" en "Lopend overzicht bijhouden (David)"
     krijgen status `doorlopend` en blijven staan.
5. **Bij twijfel of iets af is: niet verwijderen.** Status laten staan en de twijfel melden
   in de ping onder "twijfelpunten doorrol". Liever een regel te veel dan een actie kwijt.

## Verzending

Mailonderwerp volgt het patroon `Notulen [d-m]` of `Notulen [d-m] | De Goos`.

Mailbody is minimaal:

```
Hoihoi,

Hierbij de notulen.

Groet,
David
```

De notulen zitten als docx-bijlage bij de mail. Het blijft een **concept** in Outlook tot
David akkoord geeft. Dat verandert niet.

## Toon

**Notulen**: zakelijk en kort. Feiten, besluiten en actiepunten. Per onderwerp wat besloten
is, niet wat gezegd is. Geen sfeerverslag. Uitzondering is de samenvatting: die is lopende
tekst, geen bullets, en mag verhalend zijn zolang hij feitelijk blijft.

**Begeleidende mail**: informeel, begint met "Hoihoi,". Geen gedachtestreepjes, geen
vetgedrukte tekst, geen emoji.

## Uitsluitingslijst

Het volgende komt nooit in de notulen, in geen enkele vorm, ook niet geparafraseerd:

- individuele salarissen
- personele conflicten
- functioneringskwesties
- ziekteverzuim van individuen
- alles wat in het transcript als vertrouwelijk klinkt

Bij twijfel: weglaten en het aan David melden in de afsluitende ping. Twijfel is geen reden
om iets alsnog op te nemen.

Zakelijke bedragen (offertes, begrotingsposten, prijzen) mogen in de notulen zolang ze
letterlijk in het transcript staan, ook als er nog geen definitief besluit over is. Vermeld
dan de status ("offerte volgt", "nog niet definitief"). Verzonnen of geïnterpoleerde
bedragen blijven verboden, en individuele salarissen vallen onder de lijst hierboven.

## Harde regels

1. Nooit direct versturen zonder akkoord van David. Altijd eerst een concept.
2. Nooit cijfers verzinnen of interpoleren. Bedragen en datums worden letterlijk uit het
   transcript overgenomen, of ze staan er niet in.
3. Geen transcript gevonden betekent stoppen en niets versturen. Geen notulen schrijven uit
   de agenda, de mailhistorie of eerdere notulen.
4. Elke actie heeft een eigenaar. Ontbreekt die en geeft het transcript geen uitsluitsel,
   dan `(eigenaar tbd)`. Niet invullen wat aannemelijk lijkt.
5. Nooit een actie uit het Lopend overzicht verwijderen zonder dat het transcript de
   afronding bevestigt.

## WhatsApp

Nog niet geconfigureerd. David heeft de groep-JID en het bridge-endpoint nog niet; de
WhatsApp-route wordt later opgezet. Tot die tijd geldt:

- Groep-JID: **niet geconfigureerd**
- Bridge-endpoint: **niet geconfigureerd**

De skill schrijft de WhatsApp-samenvatting wel weg als bestand, maar verstuurt niets en
probeert geen verbinding te maken. Vul onderstaande waarden pas in als David ze aanlevert:

```
WHATSAPP_GROUP_JID=
WHATSAPP_BRIDGE_URL=
```

## Mapstructuur

```
CLAUDE.md
.claude/skills/notulen-de-goos/SKILL.md
templates/notulen-template.md
scripts/send_whatsapp.sh
archief/          notulen per week, als docx en als markdown
logs/             uitvoerlogs van scripts
```

Bestandsnamen in `archief/`, altijd met de **vergaderdatum**:

```
JJJJ-MM-DD Notulen De Goos.docx     de verstuurde bijlage
JJJJ-MM-DD-notulen.md               markdown-versie, bron voor de doorrol
JJJJ-MM-DD-whatsapp.txt             WhatsApp-samenvatting
```

De markdown-versie is niet optioneel: de volgende run leest daaruit het Lopend overzicht.
