{{JJJJ-MM-DD}} Notulen De Goos
Datum: {{DATUM_VOLUIT}}
Tijd: {{STARTTIJD}} uur (duur ca. {{DUUR}})
Aanwezig: {{AANWEZIG}}
Notulist: David (op basis van transcript)

## 1. Samenvatting

{{SAMENVATTING}}

## 2. Onderwerpen

### 1. {{ONDERWERP_TITEL}}

{{ONDERWERP_TEKST}}

Besluit: {{BESLUIT}}

### 2. {{ONDERWERP_TITEL}}

{{ONDERWERP_TEKST}}

<!-- meestal 5 tot 9 onderwerpen, titels volgen de vergadering van die week -->

## 3. To-do's uit deze vergadering

### Financieel & Juridisch

- {{ACTIE}} ({{EIGENAAR}})

### Personeel

- {{ACTIE}} ({{EIGENAAR}})

### Materiaal & Inrichting

- {{ACTIE}} ({{EIGENAAR}})

### Marketing, PR & Branding

- {{ACTIE}} ({{EIGENAAR}})

### Operatie & Werkritme

- {{ACTIE}} ({{EIGENAAR}} – {{DEADLINE}})

## 4. Lopend overzicht – openstaande acties

Cumulatieve stand per {{DATUM_VOLUIT}}. Alleen nog openstaande punten; afgeronde acties zijn
verwijderd. Status = open / loopt / doorlopend.

### Financieel & Juridisch

- {{ACTIE}} – {{STATUS}} ({{EIGENAAR}})

### Personeel

- {{ACTIE}} – {{STATUS}} ({{EIGENAAR}})

### Materiaal & Inrichting

- {{ACTIE}} – {{STATUS}} ({{EIGENAAR}})

### Marketing, PR & Branding

- {{ACTIE}} – {{STATUS}} ({{EIGENAAR}})

### Operatie & Werkritme

- {{ACTIE}} – {{STATUS}} ({{EIGENAAR}})

---

Invulregels voor dit template. Verwijder dit blok uit het opgeslagen bestand.

**Kop**
- De datum in de titelregel en in de bestandsnaam is de vergaderdatum, niet de verzenddatum.
- Aanwezig: voornamen, met context waar relevant, bijvoorbeeld "Sam (vanuit Frankrijk)" of
  "David (online vanuit Spanje)". Aanwezigheid komt uit het transcript, niet uit de
  agenda-uitnodiging.

**Sectie 1 Samenvatting**
- Eén lopend tekstblok, 150 tot 250 woorden. Geen bullets, geen kopjes.
- Kernbesluiten, financiële knelpunten en belangrijkste voortgang, verteld aan iemand die er
  niet bij was. Concrete bedragen en namen erin, binnen de grenzen van de uitsluitingslijst.

**Sectie 2 Onderwerpen**
- Genummerd, meestal 5 tot 9. Geen vaste agenda: de titels volgen de vergadering van die week.
- Per onderwerp korte alinea's of losse regels: wat besproken en besloten is.
- Besluiten expliciet markeren met `Besluit:`.
- Bedragen letterlijk uit het transcript, inclusief incl/ex btw waar genoemd. Niet afronden,
  niet omrekenen.

**Sectie 3 To-do's uit deze vergadering**
- Alleen nieuwe acties uit deze vergadering.
- Alle vijf categorieën altijd tonen, ook als er niets onder staat. Een lege categorie toon
  je als kop zonder regels eronder.
- Formaat: `Actie (Eigenaar)` of `Actie (Eigenaar – deadline)`.

**Sectie 4 Lopend overzicht**
- Cumulatief, doorgerold uit de vorige notulen. Alleen openstaande punten.
- De inleidende regel staat er altijd, met de datum van deze vergadering.
- Alle vijf categorieën altijd tonen.
- Formaat: `Actie – status (Eigenaar)`, status is `open`, `loopt` of `doorlopend`.
- Afgeronde acties worden verwijderd, niet doorgestreept. Bij twijfel over afronding: laten
  staan en melden in de ping.
- Ontbreekt een eigenaar en geeft het transcript geen uitsluitsel: `(eigenaar tbd)`.
