# Lesson 3 Containers
<walkthrough-directive-name name="Markus Keuter">
</walkthrough-directive-name>

**Duration**: 15 minutes

Goal of this demo is to publish a simpel web-application by:
- Building a container image,
- Run the container with Docker in the cloudshell,
- Connect to the preview.

To get started click on the shell icon [>_] to copy the text to your shell and press **ENTER**:
```bash
gcloud config set project quint-demo
```  
Press **ENTER**

Select the correct zone: 
```bash
gcloud config set compute/zone europe-west4-b
```  
## Switch folder
Switch to the correct folder by:
```bash
cd ~/cloudshell-tutorials-summerschool/orchestration
```

Press **ENTER**


## Docker Tutorial
You'll start this exercise by testing if Docker is installed in your shell by cpying the following command to your cloudshell and press **ENTER**:
```bash
docker version
```
This shows you the version of the client engine and the version of the server engine, sometimes they can be different, but this should not cause any issues for this tutorial.

## The Dockerfile
First you'll check the content of the Dockerfile, which describes the container you'll be building:
<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/orchestration/Dockerfile" text="Open Dockerfile">
</walkthrough-editor-open-file>

You see two lines of configuration, one describing which base image you'll use for this build and one line which tells Docker to copy the contents of your public folder into a location in your container. 

This 'public' location will be used to get the web content by the webserver called Nginx, which is presently the most used webserver on the Internet.


## Creating the Docker image
To build the image you'll issue the following command:
```bash
docker build -f Dockerfile -t website:v1 .
```
As mentioned in the previous step this will download the ngnix image and copy the floder public into the container.
To see what you'll be publishing click the file open:
<walkthrough-editor-open-file filePath="cloudshell-tutorials-summerschool/orchestration/public/index.html" text="Open index.html">
</walkthrough-editor-open-file>


## Run the container
From the Docker Client start a container based on the webapp:v1 image you created in the previous step. For this you use the "docker run" client command, which will connect to Container engine server API on the host and issue the commands to run the container on the host.
```bash
docker run -p 8080:80 -d website:v1
```
This will collect the image and create a running container. To check if the container is up and running you type the following:
```bash
docker ps
```
This will give you an overview of the running containers. When looking at the PORTS section you'll see a refence of publishing port 80 of the container to port 8080 on the Host tcp ip address. It looks like this:

'0.0.0.0:8080->80/tcp'

### View the website
Next you preview the website which is running on the container. Click on the Web preview button at the top right of your console <walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button">spotlight on the web preview icon</walkthrough-spotlight-pointer>, click on the button and select "Preview on port 8080".

It will open up a new tab in your browser and will show you the content of the website, running in your very own container. 

## End
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

This the end of this exercise, thank you for joining us!
