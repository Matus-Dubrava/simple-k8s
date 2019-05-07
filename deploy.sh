# build docker images
docker build -t matusdubrava/multi-client:latest -t matusdubrava/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matusdubrava/multi-server:latest -t matusdubrava/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matusdubrava/multi-worker:latest -t matusdubrava/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push docker images to docker hub
docker push matusdubrava/multi-client:latest
docker push matusdubrava/multi-server:latest
docker push matusdubrava/multi-worker:latest

docker push matusdubrava/multi-client:$SHA
docker push matusdubrava/multi-server:$SHA
docker push matusdubrava/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matusdubrava/multi-server:$SHA
kubectl set image deployments/client-deployment client=matusdubrava/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=matusdubrava/multi-worker:$SHA
