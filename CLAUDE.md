# De Goos - notulen automatisering

## Bedrijfscontext

De Goos BV exploiteert Eetcafe De Goos, Gosschalklaan 12, Westergasterrein Amsterdam.
Het bedrijf komt voort uit een rebranding vanuit Mossel & Gin.

Afzender van alle notulen en begeleidende mail: david@mosselengin.nl

## Vaste deelnemers

| Naam | E-mail | Rol |
| --- | --- | --- |
| David André | david@mosselengin.nl | organisator vergadering, afzender notulen |
| Sam Verheij | samverheij@gmail.com | tbd |
| Arno Hendriks | arnohendrikschef@gmail.com | tbd |
| Gabi Hendriks | gabrielbhendriks@gmail.com | tbd |
| Wouter ten Velde | wouter@mosselengin.nl | tbd |

Deze adressen zijn afgeleid uit de deelnemerslijst van de terugkerende Outlook-afspraak
"Meeting | De Goos" (organisator david@mosselengin.nl). De rollen zijn nog niet bevestigd
door David en staan daarom op tbd. Vul ze aan zodra ze bekend zijn, verzin ze niet.

Ontvangers van het Outlook-concept: alle deelnemers hierboven behalve de afzender zelf.

## WhatsApp

Nog niet geconfigureerd. David heeft de groep-JID en het bridge-endpoint nog niet;
de WhatsApp-route wordt later opgezet. Tot die tijd geldt:

- Groep-JID: **niet geconfigureerd**
- Bridge-endpoint: **niet geconfigureerd**

De skill schrijft de WhatsApp-samenvatting wel weg als bestand, maar verstuurt niets en
probeert geen verbinding te maken. Vul onderstaande waarden pas in als David ze aanlevert:

```
WHATSAPP_GROUP_JID=
WHATSAPP_BRIDGE_URL=
```

## Vaste agendapunten

Deze zeven punten staan altijd allemaal in de notulen, in deze volgorde, ook als een punt
niet besproken is. Een niet besproken punt krijgt de regel "Niet besproken." en verder niets.

1. Omzet en cijfers
2. Personeel en rooster
3. Keuken en inkoop
4. Marketing en events
5. De Goos rebranding en verbouwing
6. Rondvraag
7. Actiepunten

## Toon

**Notulen**: zakelijk en kort. Alleen feiten, besluiten en actiepunten. Geen proza, geen
sfeerverslag, geen samenvattend commentaar. Per agendapunt staat wat besloten is, niet wat
gezegd is.

**Begeleidende mail**: informeel. Begint met "Hoihoi,". Geen gedachtestreepjes, geen
vetgedrukte tekst, geen emoji.

## Uitsluitingslijst

Het volgende komt nooit in de notulen, in geen enkele vorm, ook niet geparafraseerd:

- individuele salarissen
- personele conflicten
- functioneringskwesties
- ziekteverzuim van individuen
- bedragen die niet expliciet als besluit bevestigd zijn
- alles wat in het transcript als vertrouwelijk klinkt

Bij twijfel: weglaten en het aan David melden in de afsluitende ping. Twijfel is geen reden
om iets alsnog op te nemen.

## Harde regels

1. Nooit direct versturen zonder akkoord van David. Altijd eerst een concept.
2. Nooit cijfers verzinnen of interpoleren. Bedragen en datums worden letterlijk uit het
   transcript overgenomen, of ze staan er niet in.
3. Geen transcript gevonden betekent stoppen en niets versturen. Geen notulen schrijven uit
   de agenda, de mailhistorie of eerdere notulen.
4. Elk actiepunt heeft een eigenaar en een deadline. Ontbreekt een van beide in het
   transcript, dan staat er letterlijk "tbd". Niet invullen wat aannemelijk lijkt.

## Mapstructuur

```
CLAUDE.md
.claude/skills/notulen-de-goos/SKILL.md
templates/notulen-template.md
scripts/send_whatsapp.sh
archief/          notulen en WhatsApp-teksten per week
logs/             uitvoerlogs van scripts
```

Bestandsnamen in archief: `JJJJ-MM-DD-notulen.md` en `JJJJ-MM-DD-whatsapp.txt`, waarbij de
datum de vergaderdatum is, niet de datum van schrijven.
