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
		for pName, pValue in s.persistent {
			// deployment: "\(n)": app_v1.#Deployment & {
			let dep_name = "\(m.name)-\(pName)"
			"\(dep_name)": app_v1.#Deployment & {
				apiVersion: "apps/v1"
				kind:       "Deployment"
				metadata:   m & {
					labels: name: dep_name
				}
				spec: {
					replicas: pValue.replicas
					selector: matchLabels: name: dep_name
					revisionHistoryLimit: int | pValue.revisionHistoryLimit | *10
					template: {
						metadata: {
							name:   dep_name
							labels: m.labels & {
								name: dep_name
							}
						}
						spec: containers: [{
							name:            dep_name
							image:           "\(pValue.imageName):\(pValue.imageTag)"
							imagePullPolicy: "IfNotPresent"
							env: [
								for k, v in pValue.env {
									name:  k
									value: v
								}
							]
						}]
					}
				}
			}
		}
	}
}
