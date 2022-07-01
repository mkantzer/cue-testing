package kube

kubernetes: service: appTwo: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			name: "appTwo"
			env: "integration"
		}
		name:      "appTwo"
		namespace: "appTwo"
	}
	spec: {
		ports: [{
			name:       "appTwo-api"
			port:       80
			targetPort: 80
		}]
		selector: name: "appTwo"
	}
}
