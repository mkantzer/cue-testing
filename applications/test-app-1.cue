package kube

namespace: "test-app-1": {
	namespace:  null
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "test-app-1"
}
deployment: "test-app-1": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "test-app-1"
	spec: {
		minReadySeconds:      10
		replicas:             2
		revisionHistoryLimit: 10
		selector: matchLabels: name: "test-app-1"
		template: {
			metadata: labels: name: "test-app-1"
			spec: containers: [{
				env: [{
					name:  "PORT"
					value: "80"
				}]
				image:           "ealen/echo-server:0.5.1"
				imagePullPolicy: "IfNotPresent"
				name:            "test-app-1"
				ports: [{
					containerPort: 80
					name:          "api"
				}]
			}]
		}
	}
}
service: "test-app-1": {
	service:    null
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: name: "test-app-1"
		name: "test-app-1"
	}
	spec: {
		ports: [{
			name:       "test-app-1-api"
			port:       80
			targetPort: 80
		}]
		selector: name: "test-app-1"
	}
}
ingress: "test-app-1": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: name: "test-app-1"
	spec: {
		ingressClassName: "nginx"
		rules: [{
			http: paths: [{
				backend: service: {
					name: "test-app-1"
					port: number: 80
				}
				path:     "/app1"
				pathType: "Prefix"
			}]
		}]
	}
}