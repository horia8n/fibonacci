docker build -t repository_name/fibonacci-client:latest -t repository_name/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t repository_name/fibonacci-server:latest -t repository_name/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t repository_name/fibonacci-worker:latest -t repository_name/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push repository_name/fibonacci-client:latest
docker push repository_name/fibonacci-server:latest
docker push repository_name/fibonacci-worker:latest

docker push repository_name/fibonacci-client:$SHA
docker push repository_name/fibonacci-server:$SHA
docker push repository_name/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=repository_name/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=repository_name/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=repository_name/fibonacci-worker:$SHA