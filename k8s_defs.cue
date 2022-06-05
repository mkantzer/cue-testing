package kube

import (
	core_v1 "k8s.io/api/core/v1"
	apps_v1 "k8s.io/api/apps/v1"
	networking_v1 "k8s.io/api/networking/v1"
	// autoscaling_v2 "k8s.io/api/autoscaling/v2"
	// batch_v1 "k8s.io/api/batch/v1"
	// policy_v1 "k8s.io/api/policy/v1"
	// meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	// rbac_v1 "k8s.io/api/rbac/v1"
)

objects: [ for v in objectSets for x in v {x}]

objectSets: [
	service,
	deployment,
	namespace,
	ingress,
]

namespace: [string]:  core_v1.#Namespace
deployment: [string]: apps_v1.#Deployment
service: [string]:    core_v1.#Service
ingress: [string]:    networking_v1.#Ingress
