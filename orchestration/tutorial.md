# Les 3 Orchstration Demo
<walkthrough-directive-name name="Markus Keuter">
</walkthrough-directive-name>

**Duur van de oefening**: ongeveer 15 minuten

Om te beginnen zetten we eerst alle instellingen die noodzakelijk zijn op.

Deze tutorial gaat uit van het project quint-demo, mocht je deze tutorial 
onafhankelijk van de training volgen, selecteer dan een eigen project.

Klik op het shell icoontje en daarna op **ENTER**:

```bash
gcloud config set project quint-demo
```  

Stel de juiste compute zone in (Eemshaven NL) 
```bash
gcloud config set compute/zone europe-west4-a
```  

**ENTER**

## Opzetten Kubectl
Kubectl is de controller van Kubernetes, met deze controller kan je via de API van 
Kubernetes, op afstand, taken laten uitvoeren op het Kubernetes cluster

```bash
gcloud components install kubectl
```

## Deze stap overslaan bij training
We geven middels gcloud de opdracht om een GKE container cluster te bouwen bestaande 
twee nodes. We noemen het cluster het persistent-disk-tutorial cluster.
```bash  
gcloud container clusters create quint-kube-orchestration --num-nodes=2
```
Dit kan een paar minuten duren....

## Verbinden met bestaand cluster
Als eerste zorg je met onderstaand commndo ervoor dat je geautoriseerd bent om
met het cluster te werken.

```bash
gcloud container clusters get-credentials quint-kube-orchestration
```
<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/provisioning/vm.yaml" text="Open configuratie bestand">
</walkthrough-editor-open-file>

```bash
kubectl apply -f mysql-volumeclaim.yaml
```

```bash
kubectl apply -f wordpress-volumeclaim.yaml
```

```bash
kubectl get pvc
```

```bash
kubectl delete pvc wordpress-volumeclaim
```

```bash
kubectl delete pvc mysql-volumeclaim
```

```bash
kubectl delete pod -l app=mysql
```

```bash
gcloud container clusters delete persistent-disk-tutorial
```


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

Klik **Next** of **Volgende** om verder te gaan.

## Configuratie Aanpassen
Om ervoor te zorgen dat je niet dezelfde omgeving neerzet als je mede-cursisten, is er één veld dat je moet aanpassen.
In het bestand zoek je `name` op en vervang je `MY_NAME` door je voornaam. 

**LET OP: GEBRUIK ALLEEN KLEINE LETTERS EN GEEN ANDERE TEKENS!**

Mocht je voornaam dus Markus zijn dan krijg je:

```yaml
  # Vul je voornaam waar MY_NAME staat, 
  # gebruik alleen kleine letters!
  name: markus
```
Om de verandering op te slaan klik je op het **File** menu, klik **Save**.

Klik **Next** of **Volgende** om verder te gaan.

## Provisioning
Om op basis van de configuratie een deployment uit te voeren type je het volgende in de cloudshell.
Eerst moet je zorgen dat je op de juiste plek staat in de folder structuur:
```bash
cd ~/cloudshell-tutorials-summerschool/provisioning
```

**ENTER** 

Hierna voer je de deployment uit, vervang hierbij `[MY_NAME]` door je eigen voornaam, alleen kleine letters, net als bij de vorige opdracht, dus ook **geen rechte haken** om je naam.

```bash
gcloud deployment-manager deployments create [MY_NAME] --config vm.yaml
```

**ENTER**

Hierna zal het even duren voor je de melding krijgt completed successfully, of een ERROR. Als je een ERROR krijgt met daarin o.a. de volgende tekst, kijk dan nog even goed naar de vorige opdracht hierboven:
```
Invalid value for field 'resource.name': '[MY_NAME]'
```

Om te controleren of je deployment succesvol was, kan je het volgende commando uitvoeren om een overzicht van alle deployments te zien:
```bash
gcloud deployment-manager deployments list
```

**ENTER**

Hierbij zie je alle Deployments, dus ook die van je collega's, als je meer informatie wil zien over je eigen deployment 
type dan het volgende (vervang weer met je voornaam, kleine letters):
```bash
gcloud deployment-manager deployments describe [MY_NAME]
```

**ENTER**

Klik **Next** of **Volgende** om verder te gaan.

## De-Provisioning
Nadat in de groep het resultaat bekeken is van alle machines kan je jouw deployment verwijderen, volg hiervoor onderstaande instructie.

### Opruimen
Om alles uiteindelijk weer netjes op te ruimen voer je volgende uit, weer met je eigen voornaam: 
```bash
gcloud deployment-manager deployments delete [MY_NAME]
```
**ENTER**

Waarna de volgende vraag verschijnt, toets een y en **ENTER**

```
Do you want to continue (y/N)? y
```
Hiermee wordt de omgeving weer schoongemaakt en worden alle zaken zoals deployment, vm, disk en netwerk verwijderd.
Klik **Next** of **Volgende** om verder te gaan.

## Einde Oefening
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Dit is het einde van de oefening terug naar 
[Gitlab Quintgroup Les 3](https://gitlab.com/quintgroup/gemeenschappelijk-werken-met-git-en-gitlab/tree/master/Les%203)
