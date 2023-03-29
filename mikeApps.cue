package kube

import (
	mikeApp_v1alpha1 "github.com/mkantzer/cue-testing/schema/mikeApp/v1alpha1"
)

mikeApp: mikeApp_v1alpha1.#MikeApp // | mikeApp_v1alpha2.#MikeApp

for a in mikeApp.spec.always if mikeApp.apiVersion == "v1alpha1" {
	kubernetes: {
		deployment: "\(mikeApp.metadata.name)-\(a.name)": {
			metadata: labels: {
				repo: mikeApp.metadata.labels.repo
				team: mikeApp.metadata.labels.team
				env:  mikeApp.metadata.labels.env
			}
			spec: {
				replicas: a.replicas
				template: spec: containers: [{
					name:  a.name
					image: "\(a.imageName):\(a.imageTag)"
					env: [ for k, v in a.env {
						name:  k
						value: v
					}]
				}]
			}
		}
	}
}
