package kube

kubernetes: deployment: [Name=_]: {
	spec: {
		selector: matchLabels: name: Name
		revisionHistoryLimit: *5 | int
		template: {
			metadata: labels: name: Name
			spec: containers: [{imagePullPolicy: "IfNotPresent"}]
		}
	}
}
