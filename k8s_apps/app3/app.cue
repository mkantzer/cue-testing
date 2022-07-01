package kube

kubernetes: {
	namespace: appThree: {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name:      "appThree"
			namespace: "appThree"
			labels: {
				name: "appThree"
				env:  string
			}
		}
	}
	deployment: appThree: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "appThree"
			namespace: "appThree"
			labels: {
				name: "appThree"
				env:  string
			}
		}
		spec: {
			minReadySeconds:      10
			replicas:             2
			revisionHistoryLimit: 10
			selector: matchLabels: name: "appThree"
			template: {
				metadata: labels: name: "appThree"
				spec: containers: [{
					env: [{
						name:  "PORT"
						value: "80"
					}]
					image:           "ealen/echo-server:0.5.1"
					imagePullPolicy: "IfNotPresent"
					name:            "appThree"
					ports: [{
						containerPort: 80
						name:          "api"
					}]
				}]
			}
		}
	}
	service: appThree: {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			labels: {
				name: "appThree"
				env:  string
			}
			name:      "appThree"
			namespace: "appThree"
		}
		spec: {
			ports: [{
				name:       "appThree-api"
				port:       80
				targetPort: 80
			}]
			selector: name: "appThree"
		}
	}
	ingress: appThree: {
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
		metadata: {
			name:      "appThree"
			namespace: "appThree"
			labels: {
				name: "appThree"
				env:  string
			}
		}
		spec: {
			ingressClassName: "nginx"
			rules: [{
				http: paths: [{
					backend: service: {
						name: "appThree"
						port: number: 80
					}
					path:     "/"
					pathType: "Prefix"
				}]
			}]
		}
	}
}
