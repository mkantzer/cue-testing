package kube

// Cloud contains the 'generic', user-facing definitions. User-defined objects should be of the types in this file.
// They are then used as seeds generate k8s-specific configuration. The definitions that do that are housed in k8s.cue
// The internal `kubernetes: {}` blocks are merged into the k8s object during convesion, allowing explicit injection of fields that aren't supported by the generic defs.

_base: {
	name: string
	label: [string]: string

	// k8s is a set of Kubernetes-specific settings that will be merged in at
	// the top-level. The allowed fields are type specfic.
	kubernetes: {}
}

deployment: [Name=_]: _base & {
	name: *Name | string // Allow any string, but use Name by default
	// kind:     *"deployment" | "stateful" | "daemon"
	kind:     "deployment"
	replicas: *1 | int

	image: string

	arg: [string]: string
	args: [ for k, v in arg {"-\(k)=\(v)"}] | [...string]

	// expose port defines named ports that are exposed in the service
	expose: port: [string]: int
	// port defines named ports that are not exposed in the service.
	port: [string]: int

	// Environment variables
	env: [string]: string

	envSpec: [string]: {}
	envSpec: {
		for k, v in env {
			"\(k)": value: v
		}
	}

	volume: [Name=_]: {
		name:      string | *Name
		mountPath: string
		subPath:   string | *null
		readOnly:  *false | true
		kubernetes: {}
	}
}

service: [Name=_]: _base & {
	name: *Name | string

	port: [Name=_]: {
		name: string | *Name

		port:     int
		protocol: *"TCP" | "UDP"
	}

	kubernetes: {}
}

// define services implied by deployments
for k, spec in deployment if len(spec.expose.port) > 0 {
	service: "\(k)": {

		// Copy over all ports exposed from containers.
		for Name, Port in spec.expose.port {
			port: "\(Name)": {
				// Set default external port to Port. targetPort must be
				// the respective containerPort (Port) if it differs from port.
				port: int | *Port
				if port != Port {
					targetPort: Port
				}
			}
		}

		// Copy over the labels
		label: spec.label
	}
}
