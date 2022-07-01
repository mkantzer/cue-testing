package kube

kubernetes: ingress: appTwo: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name:      "appTwo"
		namespace: "appTwo"
		labels: {
			name: "appTwo"
			env: "local"
		}
	}
	spec: {
		ingressClassName: "nginx"
		rules: [{
			http: paths: [{
				backend: service: {
					name: "appTwo"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
	}
}
