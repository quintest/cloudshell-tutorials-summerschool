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

**Tip**: Mocht de editor er niet staan of deze neemt teveel ruimte in dan kan deze door 
te klikken op het icoontje <walkthrough-cloud-shell-editor-icon></walkthrough-cloud-shell-editor-icon> rechtboven, 
aan en uitgezet worden.
<walkthrough-spotlight-pointer spotlightId="devshell-web-editor-button"
                               text="Open Editor">
</walkthrough-spotlight-pointer>

## Cloudshell koppelen aan Quint-demo project 
Als eerste stel je de juiste project omgeving in, zodat de virtuele machines die je gaat aanmaken in de juiste omgeving staan. 
Om het juiste project in Google Cloud in te stellen voer je volgende commando uit:
```bash
gcloud config set project quint-demo
```
Als het goed is krijg je nu de toevoeging (quint-demo) in de cloudshell te zien en staat deze ook tussen haakjes boven je cloudshell.

Verder stel je ook nog de regio in waar je machine zal verschijnen, om te zorgen dat de Eneco windmolenparken voor 
o.a. het Google datacenter in Eemshaven niet voor niets draaien..
```bash
gcloud config set compute/zone europe-west4-a
```
**ENTER**
Antwoord zal zijn dat de compute/zone zijn geupdate, klik Next

## Configuratie management
**Deployment Manager**  werkt op basis van configuratie bestanden en optioneel templates.
De tool zet configuratie bestanden in om de juiste instellingen een omgeving op te zetten, met daarin bijvoorbeeld de virtuele machine.
Klik op de instructie om het bestand te openen in de Editor:

<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/provisioning/vm.yaml" text="Open configuratie bestand">
</walkthrough-editor-open-file>

Het bestand opent zich in de editor. Allereerst een waarschuwing vooraf, **PAS NOG NIETS AAN**, 
aangezien het bestandsformaat erg gevoelig is voor spatie- en tab-indeling. Kijk eerst even naar het bestand.

### Structuur van het config bestanden
Het deployment bestand is ingedeeld volgens de sturctuur, welke je terug ziet in het geopende document: 
- **Resource**: dit is de plek waar resources beschreven worden, dit zijn resources die 
binnen de Google Cloud beschikbaar zijn
- **Type**: binnen een resource beschrijving kan je meerdere type resources inzetten zoals vm's, 
netwerk componenten
- **Name**: verplicht voor elke resource, een unieke naam
- **Properties**: de eigenschappen van de te deployen resources

De geopende configuratie beschrijft in dit geval dat we een virtuele machine instantie met de volgende eigenschappen willen laten starten:

+ Machine type: `f1-micro`
+ Image family: `debian-9`
+ Zone: `europe-west4-a`
+ Root persistent disk: `boot`
+ Een random gekozen intern en extern IP address

Klik op Next om verder te gaan 

## Configuratie Aanpassen
Om ervoor te zorgen dat je niet dezelfde omgeving neerzet als je mede-cursisten, is er één veld dat je moet aanpassen.
In het bestand vervang je `[MY_NAME]` inclusief de rechte haken door je voornaam, **LET OP ALLEEN KLEINE LETTERS!**

```
[MY_NAME] wordt dus markus
```

Om de verandering op te slaan klik je op het **File** menu, klik **Save**.
Klik op Next om verder te gaan.

## Provisioning
Om op basis van de configuratie een deployment uit te voeren type je het volgende in de cloudshell.
Eerst moet je zorgen dat je op de juiste plek staat in de folder structuur:
```bash
cd ~/cloudshell-tutorials-summerschool/provisioning
```
**ENTER** 

Hierna voer je de deployment uit, vervang hierbij `[MY_NAME]` door je eigen voornaam, alleen kleine letters.

```bash
gcloud deployment-manager deployments create [MY_NAME] --config vm.yaml
```
Hierna zal het even duren voor je de melding krijgt completed successfully, of een ERROR. Als je een ERROR krijgt met daarin o.a. de volgende tekst, kijk dan nog even goed naar de vorige opdracht hierboven:
```
Invalid value for field 'resource.name': '[MY_NAME]'
```

Om te controleren of je deployment succesvol was, kan je het volgende commando uitvoeren om een overzicht van alle deployments te zien:
```bash
gcloud deployment-manager deployments list
```
Hierbij zie je alle Deployments, dus ook die van je collega's, als je meer informatie wil zien over je eigen deployment 
type dan het volgende (vervang weer met je voornaam, kleine letters):
```bash
gcloud deployment-manager deployments describe [MY_NAME]
```

## De-Provisioning
Geef bij de docent aan dat je klaar bent dan wachten we op de rest van de groep, voer af- en toe het List commando uit om te zien wie er nog meer klaar is. **Tip** toets hiervoor pijl omhoog tot je het commando weer ziet en druk dan ENTER.

### Opruimen
Om alles uiteindelijk weer netjes op te ruimen 
```bash
gcloud deployment-manager deployments delete [MY_NAME]
```
**ENTER**

Waarna de volgende vraag verschijnt, toets een y en **ENTER**

```
Do you want to continue (y/N)? y
```
Hiermee wordt de omgeving weer schoongemaakt en worden alle zaken zoals deployment, vm, disk en netwerk verwijderd.

## Einde Oefening
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Dit is het einde van de oefening terug naar 
[Gitlab Quintgroup Les 3](https://gitlab.com/quintgroup/gemeenschappelijk-werken-met-git-en-gitlab/tree/master/Les%203)
