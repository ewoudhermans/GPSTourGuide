# GPSTourGuide

Ewoud Hermans

Applicatie beschrijving

Dit zijn de basisfeatures die samen het Minimum Viable Product vormen:

- Een melding krijgen wanneer je in de buurt van een bezienswaardigheid komt.
- Over deze bezienswaardigheid de informatie kunnen lezen die op parse is opgeslagen.
- Op een map kunnen rondkijken naar omringende bezienswaardigheden.
- Zelf op eigen locatie een bezienswaardigheid kunnen toevoegen.
- Zelf op een locatie naar keuze een bezienswaardigheid op de map kunnen toevoegen.

De TourGuide applicatie is een nieuw soort van tour guide. De app maakt gebruik van de gps-locatie van de user en geeft notificaties op het moment dat de user in de buurt van een bezienswaardigheid is. Het verschil met andere soortgelijke app’s is dat deze app geen gebruik maakt van een vaste database. Het is namelijk voor de gebruiker mogelijk zelf op locaties informatie over een bezienswaardigheden toe te voegen. Hier kan dan een titel, een tekst met informatie en een foto worden bijgevoegd. Zo vullen de gebruikers de database zelf aan en wordt de app steeds leuker naarmate er meer mensen de app beginnen te gebruiken.

Wanneer iemand de app start wordt hij of zei gevraagd om in te loggen. Wanneer die persoon nog geen account heeft is er de mogelijkheid een account aan te maken. Na het inloggen komt de user op het hoofdscherm. Hier zit de MainViewController aan verbonden. Op dit scherm is een map te zien met pin's op de locaties waar er over een bezienswaardigheid iets te lezen valt.

Boven aan dit scherm is een menu te zien met vier button's. De meest linker button is om uit te loggen. De button rechts daarvan is om op de locatie waar de user zich op het moment bevindt informatie over een bezienswaardigheid toe te voegen. De button daarnaast (een vergrootglas) gaat, wanneer er op gedrukt wordt, naar een tableview. In deze tableview zijn de tien dichtstbijzijnde bezienswaardigheden te zien. Wanneer het scherm niet meer is gecentreerd op de locatie van de user zorgt de meest rechter button ervoor dat dit wel weer het geval is.

Wanneer de user een bezienswaardigheid wilt toevoegen die zich niet op zijn huidige locatie bevindt moet hij of zei de desbetreffende locatie op de map een moment ingedrukt houden.

Technisch design

Voor deze app is er een online parse database gebruikt. Alle informatie wordt daar in een class, AddedSight genaamd, opgeslagen. In deze database worden de titels, informatie, afbeeldingen (PFFile), breedtegraad, lengtegraad en Geopoints van de bezienswaardigheden opgeslagen. Ook is er een aparte database voor de users.

Naast de parse database wordt er voor tijdelijke informatie NSUserDefaults gebruikt. NSUserDefaults wordt in de app gebruikt om locaties tussen ViewControllers door te geven.

Uitdagingen

Een probleem waar ik tegen aan liep was het opslaan en terugkrijgen van afbeeldingen in de parse database. Ze moesten uiteindelijk als PFFile worden opgeslagen en met een aparte query worden opgehaald.

Een ander lastig probleem was het plaatsen de pin’s en waar dat gedaan moest worden. Deze moesten namelijk geplaatst worden op locaties opgeslagen in de parse database. Maar aangezien de plaatsing van de pin’s in een functie moest staan die vaak werd aangeroepen werden de pin’s heel vaak geplaatst waardoor er een dikke schaduw achter de pin’s ontstond. Het duurde een hele tijd voordat de oorzaak daarvan duidelijk werd. Dit probleem is opgelost door het plaatsen van de pin’s in een if-statement waardoor ze alleen nog werden geplaatst wanneer ze nog niet aanwezig waren.

In de applicatie zit echter nog een onopgelost probleem. Wanneer de gebruiker een bezienswaardigheid wil toevoegen, maar niet op zijn eigen locatie gaat er soms iets fout. De gebruiker moet de plek waar hij de bezienswaardigheid wilt toevoegen  een moment ingedrukt houden. Vervolgens kan hij de bijbehorende informatie over de bezienswaardigheid invullen en de pin aan de map toevoegen. De eerste keer gaat dit goed en verschijnt de pin op de juiste locatie. Helaas gaat er de tweede keer wanneer een gebruiker dit probeert iets fout. De pin wordt wel geplaatst maar niet op de juiste locatie. Wanneer de app wordt afgesloten en vervolgens weer opgestart gaat het weer de eerste keer goed, maar de tweede keer verschijnt de pin niet op de juiste locatie. Het vreemde er aan is dat dit probleem zich alleen voordoet op de IPhone zelf en niet op IOS Simulator. Er is lang gezocht naar een oplossing, maar helaas vooralsnog niet gevonden.





































