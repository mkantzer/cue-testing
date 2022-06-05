package kube

import (
	apps_v1 "k8s.io/api/apps/v1"
	// autoscaling_v2 "k8s.io/api/autoscaling/v2"
	// batch_v1 "k8s.io/api/batch/v1"
	// core_v1 "k8s.io/api/core/v1"
	// networking_v1 "k8s.io/api/networking/v1"
	// policy_v1 "k8s.io/api/policy/v1"
	// meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	// rbac_v1 "k8s.io/api/rbac/v1"
)

deployment: [ID=_]: apps_v1.#Deployment & {
	metadata: name: ID
	spec: {
		replicas: *1 | int
		template: {
			metadata: labels: {
				app: ID
			}
			spec: containers: [{name: ID}]
		}
	}
}