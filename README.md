# fluxcd
A GitOps workflow example for single env deployments with Flux, Kustomize.

Run Deploy.sh for the installation and initilization of fluxCD 


kubectl get ka -A

flux reconcile kustomization flux-system --with-source

flux reconcile  kustomization application --with-source

flux reconcile  kustomization infrastructure --with-source

kubectl get ka -A
