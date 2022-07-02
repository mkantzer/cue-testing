package kube

kubernetes: {
	[string]: appThree: {
		metadata: {
			name:      "appThree"
			namespace: "appThree"
			labels: {
				name: "appThree"
				env:  string
			}
		}
	}

	namespace: appThree: {}
	deployment: appThree: {
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
