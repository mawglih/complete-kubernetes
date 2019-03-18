docker build - t mawglih/multi-client:latest -t mawglih/multi-client:$SHA -f ./client/Dockerfile ./client
docker build - t mawglih/multi-server:latest -t mawglih/multi-server:$SHA -f ./server/Dockerfile ./server
docker build - t mawglih/multi-worker:latest -t mawglih/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mawglih/multi-client:latest
docker push mawglih/multi-server:latest
docker push mawglih/multi-worker:latest
docker push mawglih/multi-client:$SHA
docker push mawglih/multi-server:$SHA
docker push mawglih/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mawglih/multi-server:$SHA
kubectl set image deployments/client-deployment client=mawglih/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mawglih/multi-worker:$SHA

