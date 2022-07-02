package kube

kubernetes: {
	[string]: appThree: {
		metadata: {
			namespace: "appThree"
		}
	}

	namespace: appThree: {}
	deployment: appThree: {
		spec: {
			minReadySeconds:      10
			replicas:             2
			revisionHistoryLimit: 10
			template: {
				spec: containers: [{
					env: [{
						name:  "PORT"
						value: "80"
					}]
					image:           "ealen/echo-server:0.5.1"
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
			// ingressClassName: "nginx"
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
