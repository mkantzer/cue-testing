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

// Funtion-like pattern from here:
// https://cuetorials.com/patterns/functions/

#PersistentInput: {
	// Note: this is NOT 1:1 with a #DrizlyApp.spec.persistent: []: {} object. It'll obv use a lot of those, but.... gonna need more, or different, or transforms
}

#PersistentOutput: {
	deployment: apps_v1.#Deployment
}

#Transform: {
	// Input for the caller
	X1="in": #PersistentInput
	// output for the caller
	out: #PersistentOutput

//  Going to need a LOT of complex transforms here, I think?
	_deployment: {
		spec: {
			X1
		}
	}

	out: {
		deployment: _deployment
	}
}
