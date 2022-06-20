# cue-testing

This repo (or at least the branches starting with `progress-##`) track my attempt to go from "raw yaml" to "cue'd up nonsense". 

## Structure

This repo is the _module_ called "github.com/mikekantzer-drizly/cue-testing"
The majority of the files in this module belong to the `kube` package.

Each valid working directory (ex: k8s_apps/[appName]/[environment], or similar for infra) is an INSTANCE. Each `instance` contains the working directory, as well as all ancestor directories within the module. 

Using this approach, the different kind of directories within a module can be ascribed the following roles:
> module root: schema
> medial directories: policy
> leaf directories: data


## Tasks

### YAML -> CUE file import

Execute this _in an instance with YAML files_:
```sh
cue import -f -l '"kubernetes"' -l 'strings.ToLower(kind)' -l 'metadata.name' -p kube *.yaml
```
You could now delete the YAML files; they have been rendered to `.cue`

### List Objects

Execute this _in an instance that has been rendered to cue_:
```
cue ls
```

### Render Cuelang to YAML at STDOUT
Execute this _in an instance that has been rendered to cue_:
```sh
cue dump
```