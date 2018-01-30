# minikube-demo
The purpose of this repo is use for a demonstration lunch and learn talk. 

## Prerequisites
Ensure you are running Docker on your Mac and that HomeBrew is installed

## Setup Instructions
Clone this repo and run the minikubeinstall.sh 

## Docker Build Steps
Using the docker file you can create your own Docker image for use with the lab. You will want to register your account on hub.docker.com. Once you have registered click create repository and give it a name of <yourname>test

```docker build . --tag <yourname>test:1```

Now change the Hello World line in the DockerFile to Hello MetalToad and save it

```docker build . --tag <yourname>test:2```

Next we want to login to dockerhub:
```docker login --username=<youraccount>```

Next we can tag our images, to get your image hash run docker ps -a:
```docker tag <hasn> <youraccount>/<reponame>:1```
```docker tag <hasn> <youraccount>/<reponame>:2```

Now we want to push both images:
```docker push <youraccount>/<reponame>:1```
```docker push <youraccount>/<reponame>:2```

## Setting up MiniKube
run the following command:
```minikube start```

To open our dashboard for minkube run:
```minikube dashboard```

Next you will want to update the information in the deploy.yml to reflect your image name :1  and save
Ensure that you've updated the container name and app name in all places for service.yml and deploy.yml

### Deploying the Service to Minikube
```kubectl create -f service.yml```
To validate your service has been created run the following:
```kubectl get services```

### Deploying the Deployment File to MiniKube
```kubectl create -f deploy.yml```
To validate your deployment you can run the following:
```kubectl get deployments```
You should now be able to navigate to the same IP address as the mikube dashboard on http port 32123 and see your Hello World message
#### Assorted Kube Status Commands:
```kubectl get pods```
```kubectl get services```
```kubectl get deployments```
```kubectl describe deploy <deployment name>```
```kubectl rollout status <deployment name>```
```kubectl rollout history <deployment name>```

### Make Deployment Changes
Change the number of replicas in the deploy.yml to 10 and save. Then run:
```kbuectl apply -f deploy.yml```
Next lets change the image used from the one ending :1 to :2 and save. Then run:
```kubectl apply -f deploy.yml --record```
You can check the status of the rollout using the following:
```kubectl rollout status <deployment name>```
Now lets say we don't like what we did and we want to roll the deployment back, we can view the history by running:
```kubectl rollout history <deployment name>```
To revert we can simply run the following (assuming we want to revert to version 1)
```kubectl rollout undo deployment <deployment name> --to-revision=1```

## Cleaning Up
```kubectl delete deployment <deployment name>```
```kubectl delete service <service name>```
```minikube stop```
