# cue-testing

This repo (or at least the branches starting with `progress-##`) track my attempt to go from "raw yaml" to "cue'd up nonsense". 

Basically, the plan is to go through the workflow shown below. For each step, i'll make a new branch from HEAD of the last branch, on which I'll do the work for that step. Hopefully, this will show some easy-to-review progress.

Steps/Plan:
1. Create an initial deployable
  - a KIND cluster config
  - Raw YAML Ingress Controller
  - Raw YAML Deployment/Service/Ingress x2
  - Raw YAML Deployment
  - Raw YAML Job (?)
  - Raw YAML Monitoring Stack
2. Use cue (with the k8s gen?) to validate the raw yaml
3. Convert raw YAML to raw CUE (no templating)
4. Attempt to set up some commands
5. Look at the Cue Guide, following a bit on how to massage or standardize things
6. Work on componetization / abstraction
7. Attempt to configure multiple deploy targets