# cue-testing

> **Note**
> This repo is still a work in progress

This repo is intended to demonstrate and track my attempts to go from "raw yaml" to "cue'd up nonsense". 


## Structure

This repo is the _module_ called "github.com/mkantzer/cue-testing"
The majority of the files in this module belong to the `kube` package.

Each valid working directory (ex: k8s_apps/[appName]/[environment], or similar for infra) is an INSTANCE. Each `instance` contains the working directory, as well as all ancestor directories within the module. 

Using this approach, the different kind of directories within a module can be ascribed the following roles:
- module root: schema
- medial directories: policy
- leaf directories: data

> **Note**
> Almost every `cue cmd` command in this repo will expect to be run from an instance.

## Instances

- **k8s_apps/appOne/[environment]**: demonstrates how to organize YAML such that it can be validated and evaluated, and have some default values added.
- **k8s_apps/appTwo/[environment]**: demonstrates how a direct import of YAML would be structured
- **k8s_apps/appThree/[environment]**: demonstrates how you can move components up towards root to reduce duplicate boilerplate. It also makes use of `cue.mod/usr` merging, to impose additional schema restrictions and further reduce boilerplate.

> **TODO:** - **k8s_apps/appFour/[environment]**: demonstrates how additional schema and transformers can be introduced to provide a more concise interface to users


## Tasks

### Validate YAML

```sh
cd k8s_apps/appOne/local
cue validateYAML
```

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