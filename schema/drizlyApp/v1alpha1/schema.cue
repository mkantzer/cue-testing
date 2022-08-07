package v1alpha1

import (
	// "strings"

	// meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	apps_v1 "k8s.io/api/apps/v1"
	// core_v1 "k8s.io/api/core/v1"
	// networking_v1 "k8s.io/api/networking/v1"
	// autoscaling_v2 "k8s.io/api/autoscaling/v2"
	// batch_v1 "k8s.io/api/batch/v1"
	// policy_v1 "k8s.io/api/policy/v1"
	// rbac_v1 "k8s.io/api/rbac/v1"
)

#DrizlyAppMetadata: {
	name: labels.app
	labels: [string]: string
	labels: {
		app:  string
		name: string
		repo: string
		team: string
		env:  "local" | "integration" | "production"
		...
	}
}

#DrizlyApp: {
	apiVersion: "v1alpha1"
	kind:       "DrizlyApp"
	metadata:   #DrizlyAppMetadata
	spec: {
		persistent: [Name=_]: {
			name:      Name
			replicas:  *3 | int
			imageName: string | *"drizlyinc/\(metadata.name)/\(Name)"
			imageTag:  string | *"latest"
			env: [Key=_]: string
			networking: [PortName=_]: {
				public:     bool | *false
				port:       int | *80
				publicPath: string | *"/"
			}
		}
		jobs: [Job=_]: {
			trigger:   "preDeploy" | "cron" | "manual" | "event"
			imageName: "drizlyinc/\(metadata.name)/\(Job)"
			imageTag:  string | *"latest"
			cmd:       string | *"up"
			env: [Key=_]: string
		}
		backingServices: [BackingName=_]: type: "postgres" | "s3" | "redis"
	}

	k8sOutput: {
		let m = metadata

		[string]: [string]: metadata: labels: {
			repo: m.labels.repo
			team: m.labels.team
			env:  m.labels.env
			app:  m.name
			...
		}
		namespace: "\(m.name)": {}

		for a in spec.persistent {
			let deploymentName = "\(m.name)-\(a.name)"
			deployment: "\(deploymentName)": apps_v1.#Deployment & {
				metadata: {
					name:      deploymentName
					namespace: m.name
					labels: name: deploymentName
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
				...
			}
		}
		...
	}
}
