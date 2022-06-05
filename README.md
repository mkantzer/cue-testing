# cue-testing

This repo (or at least the branches starting with `progress-##`) track my attempt to go from "raw yaml" to "cue'd up nonsense". 

Basically, the plan is to go through the workflow shown below. For each step, i'll make a new branch from HEAD of the last branch, on which I'll do the work for that step. Hopefully, this will show some easy-to-review progress.

## Steps/Plan:

1. Create an initial deployable
     - ~~a KIND cluster config~~
     - ~~Raw YAML Ingress Controller~~
     - ~~Raw YAML Deployment/Service/Ingress x2~~
     - Raw YAML Deployment (?) (nah... not for now)
     - Raw YAML Job (?) (nah... not for now)
     - ~~Raw YAML Monitoring Stack~~ 
       - do this later, using [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus/tree/main/manifests) (?)
2. Use cue (with the k8s gen?) to validate the CUE
3. Convert raw YAML to raw CUE (no templating)
4. Attempt to set up some commands
5. Look at the Cue Guide, following a bit on how to massage or standardize things
6. Work on componetization / abstraction
7. Attempt to configure multiple deploy targets

## `progress-01`

Create cluster and deploy local stack:
```sh
kind create cluster --config=kind.yaml
kubectl apply -f applications
```
Note: if ingress's fail to apply b/c webhooks time out, just wait a bit for the ingress controller to come up.

## `progress-02`

Import the YAML and turn it into cue syntax. 
```sh
cue import ./... -p "github.com/mikekantzer-drizly/cue-testing" -l 'strings.ToCamel(kind)' -l metadata.name -f
```