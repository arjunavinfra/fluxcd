# fluxcd
A GitOps workflow example for single env deployments with Flux, Kustomize.


kubectl get ka -A

flux reconcile  kustomization application --with-source

flux reconcile  kustomization infrastructure --with-source

kubectl get ka -A
