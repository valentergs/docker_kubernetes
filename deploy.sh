docker build -t valentergs/multi-client:latest -t valentergs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t valentergs/multi-server:latest -t valentergs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t valentergs/multi-worker:latest -t valentergs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push valentergs/multi-client:latest
docker push valentergs/multi-server:latest
docker push valentergs/multi-worker:latest
docker push valentergs/multi-client:$SHA
docker push valentergs/multi-server:$SHA
docker push valentergs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=valentergs/multi-server:$SHA
kubectl set image deployments/client-deployment client=valentergs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=valentergs/multi-worker:$SHA