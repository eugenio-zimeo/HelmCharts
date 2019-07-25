//TO CREATE
oc create -f jobmanager-service.yaml
oc create -f jobmanager-deployment.yaml
oc create -f taskmanager-deployment.yaml

//TO DELETE
oc delete -f jobmanager-service.yaml
oc delete -f jobmanager-deployment.yaml
oc delete -f taskmanager-deployment.yaml