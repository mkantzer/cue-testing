package kube

kubernetes: {
	[string]: appFour: {
		metadata: {
			name:      "appFour"
			namespace: "appFour"
			labels: {
				name: "appFour"
				env:  string
			}
		}
	}

	namespace: appFour: {}
	deployment: appFour: {
		spec: {
			minReadySeconds:      10
			replicas:             2
			revisionHistoryLimit: 10
			selector: matchLabels: name: "appFour"
			template: {
				metadata: labels: name: "appFour"
				spec: containers: [{
					env: [{
						name:  "PORT"
						value: "80"
					}]
					image:           "ealen/echo-server:0.5.1"
					imagePullPolicy: "IfNotPresent"
					name:            "appFour"
					ports: [{
						containerPort: 80
						name:          "api"
					}]
				}]
			}
		}
	}
	service: appFour: {
		spec: {
			ports: [{
				name:       "appFour-api"
				port:       80
				targetPort: 80
			}]
			selector: name: "appFour"
		}
	}
	ingress: appFour: {
		spec: {
			ingressClassName: "nginx"
			rules: [{
				http: paths: [{
					backend: service: {
						name: "appFour"
						port: number: 80
					}
					path:     "/"
					pathType: "Prefix"
				}]
			}]
		}
	}
}
