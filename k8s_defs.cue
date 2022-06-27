package kube

import (
	"strings"
	core_v1 "k8s.io/api/core/v1"
	apps_v1 "k8s.io/api/apps/v1"
	networking_v1 "k8s.io/api/networking/v1"
	// autoscaling_v2 "k8s.io/api/autoscaling/v2"
	// batch_v1 "k8s.io/api/batch/v1"
	// policy_v1 "k8s.io/api/policy/v1"
	// meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	// rbac_v1 "k8s.io/api/rbac/v1"
)

kubernetes: [Kind=_]: [Name=_]: {
	apiVersion: string
	kind:       strings.ToTitle(Kind)
}

k8sObjects: [
	for kind in kubernetes
	for object in kind {object},
]

// objects: [ for v in objectSets for x in v {x}]

// objectSets: [
//  service,
//  deployment,
//  namespace,
//  ingress,
// ]

kubernetes: {
	namespace: [string]:  core_v1.#Namespace
	deployment: [string]: apps_v1.#Deployment
	service: [string]:    core_v1.#Service
	ingress: [string]:    networking_v1.#Ingress
}

// Things used _for now_ for loose validation. Will likely go away soon, or be otherwise refactored
// #Schema: core_v1.#Namespace | apps_v1.#Deployment | core_v1.#Service | networking_v1.#Ingress
#Schema: #Namespace | #Deployment | #Service | #Ingress

#Namespace: {
	apiVersion: "v1"
	kind:       "Namespace"
	...
}

#Deployment: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	...
}

#Service: {
	apiVersion: "v1"
	kind:       "Service"
	...
}

#Ingress: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	...
}
