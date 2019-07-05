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
gcloud config set compute/zone europe-west4-b
```  

**ENTER**

## Opzetten Kubectl
Kubectl is de controller van Kubernetes, met deze controller kan je via de API van 
Kubernetes, op afstand, taken laten uitvoeren op het Kubernetes cluster

```bash
gcloud components install kubectl
```

## Kubernetes Cluster Bouwen
We geven middels gcloud de opdracht om een GKE container cluster te bouwen bestaande 
twee nodes. In de training setting van Summerschool heb je geen rechten om dit te bouwen, deze stap staat in de tutorial wanneer je dit wil bouwen in je eigen Google Cloud omgeving. 
We noemen het cluster het persistent-disk-tutorial cluster.
```bash  
gcloud container clusters create quint-kube-orchestration --num-nodes=3
```
Dit kan een paar minuten duren....

## Verbinden met bestaand cluster
Als eerste zorg je met onderstaand commndo ervoor dat je geautoriseerd bent om
met het cluster te werken.

```bash
gcloud container clusters get-credentials quint-kube-orchestration
```

## Aanmaken persistent storage
Zodra dit is gelukt, kan je naar folder met configuratie bestanden navigeren:
```bash
cd ~/cloudshell-tutorials-summerschool/orchestration
```
En daarna op je door onderstaande link te klikken het configuratie bestand voor het aanmaken van een schijf voor de databse container.

<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/orchestration/mysql-volumeclaim.yaml" text="Open configuratie bestand mysql-volumeclaim.yaml">
</walkthrough-editor-open-file>

Deze Yaml file beschrijft een zogenaamde claim op een harde schijf van 200GB die aangemaakt wordt op basis van de opgegeven naam. Deze schijf wordt gebruikt voor de 
MySQL database en door deze buiten de container aan te maken van MySQL zelf, is de data veilig en beschikbaar bij uitzetten, vervangen of verwijderen van
de container.
Met het onderstaande commando maak je deze claim aan.

```bash
kubectl apply -f mysql-volumeclaim.yaml
```

Ditzelfde doen we ook voor de Wordpress applicatie server schijf:
```bash
kubectl apply -f wordpress-volumeclaim.yaml
```

Controlleer of je de schijven bestaan:
```bash
kubectl get pvc
```

## Deployement van MySQL Container

```bash
kubectl create secret generic mysql --from-literal=password=YOUR_PASSWORD
```
Door op onderstaande link te klikken open je het zogenaamde manifest bestand van de MySQL container. 

<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/orchestration/mysql.yaml" text="Open configuratie bestand mysql.yaml">
</walkthrough-editor-open-file>
Op basis van dit manifest, wordt de container gebouwd, zodra je onderstaand commando uitvoert:

```bash
kubectl create -f mysql.yaml
```
Om te controlleren of de container (ook wel Pod genoemd in Kubernetes) bestaat, controlleer je dit:
```bash
kubectl get pod -l app=mysql
```

Om gebruik te kunnen maken van de MySQL server, zal deze als Service gepubliceerd worden binnen het Kubernetes cluster 

```bash
kubectl create -f mysql-service.yaml
```

## Wordpress Container Aanmaken
Ook hier starten we met het aanmaken van de container
```bash
kubectl create -f wordpress.yaml
```

**LET OP**: hierna wordt het echter anders. De Wordpress Service ga je namelijk op Internet publiceren. Hierbij maak je gebruik van de 
LoadBalancer service van Google. Je Wordpress container is op moment van publicatie beschikbaar voor iedereen die het IP adres heeft. 
Het is dus belangrijk om de volgende handelingen achter elkaar uit te voeren en hier niet een paar uur tussen te laten zitten.

```bash
kubectl create -f wordpress-service.yaml
```

Controleer of je al een External LoadBalancer IP adres hebt door volgende opdracht uit te voeren:

```bash
kubectl get svc -l app=wordpress
```

Zodra je iets ziet dat op volgende lijkt is de service beschikbaar:
```
NAME        CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
wordpress   10.51.243.233   203.0.113.3    80:32418/TCP   1m
```
Copieer het EXTERNAL-IP adres dat je in de console ziet in een browser en navigeer naar de Word[press pagine, volg de instructies en je 
Wordpress pagina is een feit.


## Opruimen
Voer de onderstaande opdrachten uit om de omgeving op te ruimen:

```bash
kubectl delete service wordpress
```


```bash
kubectl delete pod -l app=mysql
``

```bash
kubectl delete pvc wordpress-volumeclaim
```

```bash
kubectl delete pvc mysql-volumeclaim
```
`

```bash
gcloud container clusters delete persistent-disk-tutorial
```
Om zeker te zijn dat je geen rekening meer krijgt voor de omgeving, kan je het project ontkoppelen van je Billing account of het project als geheel weggooien.
