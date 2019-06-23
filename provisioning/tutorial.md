# Les 2 Oefening Provisioning
<walkthrough-directive-name name="Markus Keuter">
</walkthrough-directive-name>

**Duur van de oefening**: ongeveer 15 minuten
## Doel
Aan het einde van de les heb je gezien hoe je door het aanpassen van configuratie bestanden een omgeving kan aanmaken, 
zonder handmatig nog in te grijpen gedurende de provisioning fase. Klik op de **Next** of **Volgende** button onderaan je scherm 
om naar het volgende deel van de oefening te gaan.

### De instructie omgeving
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
Hierbij wordt de tekst naar je shell gekopieerd en kan je door Enter te drukken het commando uitvoeren. Daarbij wordt de tekst tussen
de aanhalingstekens op de regel eronder getoond.

Klik op **Next** of **Volgende** om verder te gaan, hierna kan je via de navigatie buttons onderaan vooruit of terug in de tutorial.

## De Cloud Shell
Allereerst maken je kennis met de cloudshell, dit is het zwarte horizontale venster links onderaan het scherm. 
Dit is de command-prompt die je van Google krijgt als je handelingen niet via het menu (klik) maar op basis van tekst invoer wil uitvoeren.
Dit wil je wel eens doen omdat het na enige oefening sneller is dan via het menu werken, maar ook omdat je de regels zoals je 
deze achter elkaar typt, kan uit laten voeren via een zogenaamd script. Hierdoor zijn deze handelingen herhaalbaar uit te voeren.

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

Om te voorkomen dat je voortdurend de vragen krijgt of je een service wil opstarten zet je deze services met het volgende commando aan:
```bash
gcloud services enable compute container deploymentmanager dns
```
Zodra je dit commando uitvoert, zal het even kunnen duren voor dit klaar is. Mocht er een ERROR verschijnen, laat dit dan even weten.

## Configuratie management
Je maakt gebruik van de Google eigen tooling **Deployment Manager** om de servers in deze oefening aan te zetten.
De tool zet configuratie bestanden in om de juiste instellingen een omgeving op te zetten, met daarin bijvoorbeeld de virtuele machine.
Om ervoor te zorgen dat je niet allemaal dezelfde omgeving neerzet, is er een veld dat je moet aanpassen.

Klik op de instructie om het bestand te openen in de Editor:

<walkthrough-editor-open-file filePath="~/cloudshell-tutorials-summerschool/provisioning/vm.yaml">
open het bestand vm.yaml</walkthrough-editor-open-file>

Het bestand opent zich in de editor. Allereerst een waarschuwing vooraf, PAS NOG NIETS AAN, 
aangezien het bestandsformaat erg gevoelig is voor spatie- en tab-indeling.

### Structuur van het config bestanden
Het deployment bestand is ingedeeld volgens de sturctuur: 
- **Resource**: dit is de plek waar resources beschreven worden, dit zijn resources die 
binnen de Google Cloud beschikbaar zijn
- **Type**: binnen een resource beschrijving kan je meerdere type resources inzetten zoals vm's, 
netwerk componenten
- **Name**: verplicht voor elke resource, een unieke naam
- **Properties**: de eigenschappen van de te deployen resources

Daarnaast is er de mogelijkheid om samenstelling van resources (bijvoorbeeld een vm en een database 
service) als een deployment te beschrijven. Ook kan er gebruik gemaakt worden van templates en deployments van 
derde partijen op de Google Cloud Marketplace. Voor deze oefening gaat dit echter te ver, belangrijkste om te 
onthouden dat de tooling het mogelijk maakt flexibel deployments te bouwen aan de hand van de configuratie.

## Configuratie Invullen
De geopende configuratie beschrijft in dit geval een virtuele machine instantie met de volgende eigenschappen:

+ Machine type: `f1-micro`
+ Image family: `debian-9`
+ Zone: `europe-west4-a`
+ Root persistent disk: `boot`
+ Een random gekozen intern en extern IP address

In het bestand vervang je de volgende placeholder:

* `[MY_NAME]` met je **voornaam** LET OP ALLEEN KLEINE LETTERS!
 
Om de verandering op te slaan klik je op het **File** menu, klik **Save**.

## Provisioning
Om op basis van de configuratie een deployment uit te voeren type je het volgende in de cloudshell.
Eerst moet je zorgen dat je op de juiste plek staat in de folder structuur:
```bash
cd ~/cloudshell-tutorials-summerschool/provisioning
```
Hierna voer je de deployment uit, vervang hierbij `[MY_NAME]` door je eigen voornaam, alleen kleine letters.

```bash
gcloud deployment-manager deployments create [MY_NAME] --config vm.yaml
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
Geef bij de docent aan dat je klaar bent dan wachten we op de rest van de groep, voer af- en toe het List commando uit om te zien wie er nog meer 
klaar is. **Tip** toets hiervoor pijl omhoog tot je het commando weer ziet en druk dan Enter.

### Opruimen
Om alles uiteindelijk weer netjes op te ruimen 
```bash
gcloud deployment-manager deployments delete [MY_NAME]
```
Waarna de volgende vraag verschijnt, toets een y en Enter

```
Do you want to continue (y/N)? y
```
Hiermee wordt de omgeving weer schoongemaakt en worden alle zaken zoals deployment, vm, disk en netwerk verwijderd.

## Einde Oefening
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Dit is het einde van de oefening terug naar 
[Gitlab](https://gitlab.com/quintgroup/gemeenschappelijk-werken-met-git-en-gitlab/tree/master/Les%203)
