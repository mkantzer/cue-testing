package kubeButYAML

// Things used _for now_ for loose YAML validation of app1. Will likely go away soon, or be otherwise refactored
#Schema: #Namespace | #Deployment | #Service | #Ingress

#Namespace: {
	apiVersion: "v1"
	kind:       "Namespace"
	...
}

#Deployment: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	...
}

#Service: {
	apiVersion: "v1"
	kind:       "Service"
	...
}

#Ingress: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	...
}
