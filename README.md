# cue-testing

A lot of this is me working through https://cuetorials.com/first-steps/validate-configuration/
Next Step: https://cuetorials.com/first-steps/generate-configuration/


and then maybe also playing around with some k8s tooling?

## Reading the top-level stuff:
- `generic.cue`: contains "generic" application definition schema. These are the user-facing interface, that will be used to specify "inputs"
- `proj_defaults.cue`: contains some default labels to apply to all objects
- `k8s.cue`: contains the generic -> kubernetes transformations