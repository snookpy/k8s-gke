docker build -t nuenook/multi-client:latest -t nuenook/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nuenook/multi-server:latest -t nuenook/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nuenook/multi-worker:latest -t nuenook/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nuenook/multi-client
docker push nuenook/multi-server
docker push nuenook/multi-worker

docker push nuenook/multi-client:$SHA
docker push nuenook/multi-server:$SHA
docker push nuenook/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=nuenook/multi-server:$SHA
kubectl set image deployment/client-deployment client=nuenook/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=nuenook/multi-worker:$SHA