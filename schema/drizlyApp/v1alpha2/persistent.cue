package v1alpha2

import (
	app_v1 "k8s.io/api/apps/v1"
)

#PersistentSpec: {
	name:      string
	imageName: string
	imageTag:  string | *"latest"
	...
}

#DrizlyApp: {
	metadata: _
	spec:     _

	let m = metadata
	let s = spec

	_persistentGen: deployment: {
		for n, v in s.persistent {
			// deployment: "\(n)": app_v1.#Deployment & {
			let dep_name = "\(m.name)-\(n)"
			"\(dep_name)": app_v1.#Deployment & {
				apiVersion: "apps/v1"
				kind:       "Deployment"
				metadata:   m & {
					labels: name: dep_name
				}
				spec: {
					replicas: *1 | int
					selector: matchLabels: name: dep_name
					revisionHistoryLimit: *5 | int
					template: {
						metadata: m
						metadata: labels: name: dep_name
						spec: containers: [{
							name:            dep_name
							imagePullPolicy: "IfNotPresent"
						}]
					}
				}
			}
		}
	}
}
