package kube

namespace: "test-app": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "test-app"
}
deployment: "test-app": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "test-app"
		namespace: "test-app"
	}
	spec: {
		minReadySeconds:      10
		replicas:             2
		revisionHistoryLimit: 10
		selector: matchLabels: name: "test-app"
		template: {
			metadata: labels: name: "test-app"
			spec: containers: [{
				env: [{
					name:  "PORT"
					value: "80"
				}]
				image:           "ealen/echo-server:0.5.1"
				imagePullPolicy: "IfNotPresent"
				name:            "test-app"
				ports: [{
					containerPort: 80
					name:          "api"
				}]
			}]
		}
	}
}
service: "test-app": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: name: "test-app"
		name:      "test-app"
		namespace: "test-app"
	}
	spec: {
		ports: [{
			name:       "test-app-api"
			port:       80
			targetPort: 80
		}]
		selector: name: "test-app"
	}
}
service: "test-app": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: name: "test-app"
		name:      "test-app"
		namespace: "test-app"
	}
	spec: {
		ports: [{
			name:       "test-app-api"
			port:       80
			targetPort: 80
		}]
		selector: name: "test-app"
	}
}
ingress: "test-app": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name:      "test-app"
		namespace: "test-app"
	}
	spec: {
		ingressClassName: "nginx"
		rules: [{
			http: paths: [{
				backend: service: {
					name: "test-app"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
	}
}
