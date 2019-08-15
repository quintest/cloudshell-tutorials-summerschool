# Les 2 Oefening Provisioning
<walkthrough-directive-name name="Markus Keuter">
</walkthrough-directive-name>

**Duur van de oefening**: ongeveer 15 minuten
## De instructie omgeving
De tekst die je nu leest staat hier standaard niet, dit is een zogenaamde cloudshell tutorial omgeving. 
Dit maakt het mogelijk om de oefening te voorzien van interactieve objecten zoals de Next button, 
maar ook links naar andre sites en het heeft een spotlight functie, waarmee onderdelen in de gebruikersinterface 
uitgelicht kunnen worden.

### Tekst kopieeren
Voer als eerste de volgende handeling uit om te gevoel te krijgen bij de tutorial omgeving.
Klik op het shell icoontje <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> naast de onderstaande tekst:
```bash
echo "Hello Quint Summerschool"
```
Hierbij wordt de tekst naar je shell gekopieerd en kan je door **Enter** te drukken het commando uitvoeren. Daarbij wordt de tekst tussen de aanhalingstekens op de regel eronder getoond.

Klik op **Next** of **Volgende** om verder te gaan, hierna kan je via de navigatie buttons onderaan vooruit of terug in de tutorial.

## De Cloud Shell
Allereerst maak je kennis met de cloudshell, dit is het zwarte horizontale venster links onderaan het scherm. 
Dit is de command-prompt die je van Google krijgt als je handelingen niet via het menu (klik) maar op basis van tekst invoer wil uitvoeren.

### De Cloud editor
Boven de cloudshell staat een groot vlak met aan de zijkant een folder structuur, dit is de cloud-shell-editor. 
Deze editor maakt het eenvoudiger om tekst bestanden aan te maken en aan te passen. 
Je zal deze editor verderop in de tutorial inzetten om configuratie bestanden mee aan te passen.

Klik **Next** of **Volgende** om verder te gaan.

## Cloudshell koppelen aan Quint-demo project 
Als eerste stel je de juiste project omgeving in, zodat de virtuele machines die je gaat aanmaken in de juiste omgeving staan. 
Om het juiste project in Google Cloud in te stellen voer je volgende commando uit:
```bash
gcloud config set project quint-demo
```

**ENTER**

Als het goed is krijg je nu de toevoeging (quint-demo) in de cloudshell te zien en staat deze ook tussen haakjes boven je cloudshell.

Verder stel je ook nog de regio in waar je machine zal verschijnen, om te zorgen dat de Eneco windmolenparken voor 
o.a. het Google datacenter in Eemshaven niet voor niets draaien..
```bash
gcloud config set compute/zone europe-west4-a
```

**ENTER**

Antwoord zal zijn dat de compute/zone zijn geupdate. Als volgende zetten we een systeem variabele zodat je telkens de juiste naam gebruikt. Vervang jevoornaam door je eigen voornaam.

**Zorg ervoor dat je ALLEEN KLEINE LETTERS gebruikt, geen spaties of leestekens!**

```bash
export MY_NAME=jevoornaam
```

klik **Next** of **Volgende** om verder te gaan.

## Configuratie management
**gcloud en templates**  werkt op basis van configuratie commando's, configuratie bestanden en templates.
De tool zet configuratie bestanden in om de juiste instellingen een omgeving op te zetten, met daarin bijvoorbeeld de virtuele machine.
Klik op de instructie om het bestand te openen in de Editor:

<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/provisioning/example-template-custom" text="Open template bestand">
</walkthrough-editor-open-file>

Het bestand opent zich in de editor.

### Gebruik en opbouw van templates
Templates worden gebruikt om zogenaamde instances van virtuele machines (servers) te beschrijven. Elke cloud provider heeft hier een eigen manier voor die sterk afhankelijk is van het type resource welke je wil beschrijven en het type van resources waarvan je gbruik wil maken. 

In deze tutorial gebruik je:

+ Machine type: `g1-micro`
+ Image family: `debian-9`
+ Root persistent disk: `boot`
+         - van 250GB groot
+ Een random gekozen intern IP address

Verder maken we gebruik van een script om machines te voorzien van de juiste software, in ons geval is dat Nginx, één van de meest gebruikte webservers in de wereld. Dit script kan je hier bekijken:

<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/provisioning/startup-script.sh" text="Open startup-script.sh bestand">
</walkthrough-editor-open-file>

Klik **Next** of **Volgende** om verder te gaan.


## Provisioning
Om ervoor te zorgen dat je niet dezelfde omgeving neerzet als je mede-cursisten, heeft iedereen als het goed is een andere MY_NAME variabele gekozen.

Om op basis van de configuratie een deployment uit te voeren type je het volgende in de cloudshell.
Eerst moet je zorgen dat je op de juiste plek staat in de folder structuur:
```bash
cd ~/cloudshell-tutorials-summerschool/provisioning
```

**ENTER** 

Hierna voer je de deployment uit:

```bash
gcloud compute instances create $MY_NAME --source-instance-template example-template-custom-1 --network-interface=no-address --metadata-from-file startup-script=startup-script.sh
```

Hiermee wordt je machine aangemaakt, met jouw unieke naam. Zodra de machine klaar is zet je deze in een pool van machines die een website laten zien.

```bash
gcloud compute instance-groups unmanaged add-instances instance-group-1 --instances $MY_NAME --zone europe-west4-a
```

**ENTER**

Hierna zal het even duren voor je de melding krijgt completed successfully, of een ERROR. Als je een ERROR krijgt met daarin o.a. de volgende tekst, kijk dan nog even goed naar de vorige opdracht hierboven:
```
Invalid value for field 'resource.name': '[MY_NAME]'
```

## De-Provisioning
Nadat in de groep het resultaat bekeken is van alle machines kan je jouw machine verwijderen, volg hiervoor onderstaande instructie.

### Opruimen
Om alles uiteindelijk weer netjes op te ruimen voer je volgende uit, weer met je eigen voornaam: 
```bash
gcloud compute instance delete $MY_NAME
```
**ENTER**

Waarna de volgende vraag verschijnt, toets een y en **ENTER**

```
Do you want to continue (y/N)? y
```
Hiermee wordt de omgeving weer schoongemaakt en worden alle zaken zoals deployment, vm, disk en netwerk verwijderd.
Klik **Next** of **Volgende** om verder te gaan.

## Einde Oefening
Zodra je klaar bent met de oefening voer je onderstaande uit, zodat je de bij de volgende oefening weer met een schone omgeving start:

```bash
cd ~ && rm -rf cloudshell-tutorials-summerschool/
```

**ENTER**

En sluit je het browser tab-blad.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Dit is het einde van de oefening terug naar 
[Gitlab Quintgroup Les 3](https://gitlab.com/quintgroup/gemeenschappelijk-werken-met-git-en-gitlab/tree/master/Les%203)
