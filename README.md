# Docs

docker-compose up --build

Then, can view project at localhost:3050



## Creating a secret environment variable
```bash
kubectl create secret generic <secret_name> --from-literal key=value
```


## Google Cloud 
Can use Google Cloud Shell to run these commands. 
```bash
# Congiure GCloud CLI on Cloud Console (These are essentially the same commands we had to run in our .travis.yml script as well)
gcloud config set project supple-defender-261517
gcloud config set compute/zone us-central1-a
gcloud container clusters get-credentials multi-cluster
```
Must manually run command to set secret 
```bash
# Set postgres password (needs to be the same as secretKeyRef->name that resides in server-deployment.yaml scripts, etc).
kubectl create secret generic pgpassword --from-literal PGPASSWORD=<password_here>
```
Can now see pgpassword secret under the Google Cloud -> Kubernetes Engine -> Configuration settings


```bash
# Install Helm on cloud console (https://helm.sh/docs/intro/install/#from-script)
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh

# Install nginx-ingress (https://kubernetes.github.io/ingress-nginx/deploy/#using-helm - the docs here seem dated got error when running "helm install stable/nginx-ingress --name my-nginx". Got error of "Error: unknown flag: --name")
# NOTE: GKE has RBAC enabled by default
# These commands came from Udemy Lecture 269 (Helm v3 Update)
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install my-nginx stable/nginx-ingress --set rbac.create=true 
```



https://github.com/kubernetes/ingress-nginx


Best practices:
* Create routes in application to health check of application 