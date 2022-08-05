package kube

kubernetes: deployment: [Name=_]: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	spec: {
		replicas: *1 | int
		selector: matchLabels: name: Name
		revisionHistoryLimit: *5 | int
		template: {
			metadata: labels: name: Name
			spec: containers: [{imagePullPolicy: "IfNotPresent"}]
		}
	}
}
