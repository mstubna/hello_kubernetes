#!/bin/bash
# exit on any error
set -e

# clean up any stale jobs
kubectl delete job hello-kubernetes-db-migrate 2&> /dev/null || true

# create the migration job
kubectl apply -f deploy/k8s/jobs/job-migrate2.yml

# monitor for completion of the migration job
while [ true ]; do
  succeeded=`kubectl get jobs hello-kubernetes-db-migrate -o 'jsonpath={.status.succeeded}'`
  failed=`kubectl get jobs hello-kubernetes-db-migrate -o 'jsonpath={.status.failed}'`
if [[ "$succeeded" == "1" ]]; then
    echo 'Migration task succeeded!'
    kubectl delete job hello-kubernetes-db-migrate
    break
  elif [[ "$failed" -gt "0" ]]; then
    echo 'Migration task failed!'
    kubectl describe job hello-kubernetes-db-migrate
    kubectl delete job hello-kubernetes-db-migrate
    exit 1
  fi
done
