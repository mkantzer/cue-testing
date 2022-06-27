package kube

kubernetes: namespace: appOne: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "appOne"
}
kubernetes: deployment: appOne: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "appOne"
		namespace: "appOne"
	}
	spec: {
		minReadySeconds:      10
		replicas:             2
		revisionHistoryLimit: 10
		selector: matchLabels: name: "appOne"
		template: {
			metadata: labels: name: "appOne"
			spec: containers: [{
				env: [{
					name:  "PORT"
					value: "80"
				}]
				image:           "ealen/echo-server:0.5.1"
				imagePullPolicy: "IfNotPresent"
				name:            "appOne"
				ports: [{
					containerPort: 80
					name:          "api"
				}]
			}]
		}
	}
}
kubernetes: service: appOne: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: name: "appOne"
		name:      "appOne"
		namespace: "appOne"
	}
	spec: {
		ports: [{
			name:       "appOne-api"
			port:       80
			targetPort: 80
		}]
		selector: name: "appOne"
	}
}
kubernetes: ingress: appOne: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name:      "appOne"
		namespace: "appOne"
	}
	spec: {
		ingressClassName: "nginx"
		rules: [{
			http: paths: [{
				backend: service: {
					name: "appOne"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
	}
}
