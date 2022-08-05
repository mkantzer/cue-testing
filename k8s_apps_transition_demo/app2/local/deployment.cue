package kube

kubernetes: deployment: appTwo: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "appTwo"
		namespace: "appTwo"
		labels: {
			name: "appTwo"
			env: "local"
		}
	}
	spec: {
		minReadySeconds:      10
		replicas:             2
		revisionHistoryLimit: 10
		selector: matchLabels: name: "appTwo"
		template: {
			metadata: labels: name: "appTwo"
			spec: containers: [{
				env: [{
					name:  "PORT"
					value: "80"
				}]
				image:           "ealen/echo-server:0.5.1"
				imagePullPolicy: "IfNotPresent"
				name:            "appTwo"
				ports: [{
					containerPort: 80
					name:          "api"
				}]
			}]
		}
	}
}