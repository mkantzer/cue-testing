# cue-testing

This repo (or at least the branches starting with `progress-##`) track my attempt to go from "raw yaml" to "cue'd up nonsense". 

## YAML -> CUE file import

Execute this _in the directory with the YAML files_:
```sh
cue import -f -l 'strings.ToLower(kind)' -l 'metadata.name' -p kube *.yaml
```
You could now delete the YAML files; they have been rendered to `.cue`

## Render Cuelang to YAML at STDOUT
Execute this in a directory under `k8s_apps`:
```sh
cue dump
```