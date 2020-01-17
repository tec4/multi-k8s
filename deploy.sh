# Build new docker images w/ latest and Git SHA tags
docker build -t ericwatts/multi-docker-deploy-client:latest -t ericwatts/multi-docker-deploy-client:$SHA -f ./client/Dockerfile ./client
docker build -t ericwatts/multi-docker-deploy-server:latest -t ericwatts/multi-docker-deploy-server:$SHA -f ./server/Dockerfile ./server
docker build -t ericwatts/multi-docker-deploy-worker:latest -t ericwatts/multi-docker-deploy-worker:$SHA -f ./worker/Dockerfile ./worker

# Push newly built images to registry w/ latest tag
docker push ericwatts/multi-docker-deploy-client:latest
docker push ericwatts/multi-docker-deploy-server:latest
docker push ericwatts/multi-docker-deploy-worker:latest

# Push newly built images to registry w/ Git SHA tag
docker push ericwatts/multi-docker-deploy-client:$SHA
docker push ericwatts/multi-docker-deploy-server:$SHA
docker push ericwatts/multi-docker-deploy-worker:$SHA

# Apply changes to kubernetes
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ericwatts/multi-docker-deploy-client:$SHA
kubectl set image deployments/server-deployment server=ericwatts/multi-docker-deploy-server:$SHA
kubectl set image deployments/worker-deployment worker=ericwatts/multi-docker-deploy-worker:$SHA
