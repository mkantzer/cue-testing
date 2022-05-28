// Package k8s contains constraints and defaults on top of raw Kubernetes
// resources.
package k8s

// Custom constraints could have been added to the //cue.mod/usr/ directory,
// but opted to use this so that users have the option of using completely
// unconstrained definitions if necessary.

import (
	apps_v1 "k8s.io/api/apps/v1"
	autoscaling_v2 "k8s.io/api/autoscaling/v2"
	batch_v1 "k8s.io/api/batch/v1"
	core_v1 "k8s.io/api/core/v1"
	networking_v1 "k8s.io/api/networking/v1"
	policy_v1 "k8s.io/api/policy/v1"
	meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	rbac_v1 "k8s.io/api/rbac/v1"
  storage_v1 "k8s.io/api/storage/v1"
)


// ConfigMap is a constrained definition of a `core/v1.ConfigMap`.
//
// See http://go/k8s-api/config-and-storage-resources/config-map-v1 for more
// information.
#ConfigMap: core_v1.#ConfigMap & {
	apiVersion: "v1"
	kind:       "ConfigMap"
}

// CronJob is a constrained definition of a `batch/v1beta.CronJob`.
//
// See http://go/k8s-api/workload-resources/cron-job-v1 for more information.
#CronJob: batch_v1.#CronJob & {
	apiVersion: "batch/v1"
	kind:       "CronJob"

	spec: jobTemplate: spec: #JobSpec
}

// Deployment is a constrained definition of a `apps/v1.Deployment`.
//
// See http://go/k8s-api/workload-resources/deployment-v1 for more information.
#Deployment: X=apps_v1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"

	metadata: labels: {
		// Reserved labels.
		version: "main"
	}

	spec: {
		revisionHistoryLimit: int | *5

		strategy: {
			type: string | *"RollingUpdate"
			if type == "RollingUpdate" {
				rollingUpdate: {
					maxSurge:       int | string | *"50%"
					maxUnavailable: int | string | *"0%"
				}
			}
		}

		template: {
			metadata: labels: X.metadata.labels
			spec: #PodSpec & {
				terminationGracePeriodSeconds: int & >90 | *90
			}
		}
	}
}


// HorizontalPodAutoscaler is a constrained definition of a
// `autoscaling/v2.HorizontalPodAutoscaler`.
//
// See http://go/k8s-api/workload-resources/horizontal-pod-autoscaler-v2
// for more information.
#HorizontalPodAutoscaler: X=autoscaling_v2.#HorizontalPodAutoscaler & {
	apiVersion: "autoscaling/v2"
	kind:       "HorizontalPodAutoscaler"

	spec: {
		scaleTargetRef: name: string | *X.metadata.name
		maxReplicas: int | *3
		minReplicas: int & >0 & <=maxReplicas | *2

		behavior: {
			scaleUp: {
				stabilizationWindowSeconds: int & >=0 | *0
				policies:                   null | *[{
					type:          "Percent"
					value:         100
					periodSeconds: 15
				}]
				selectPolicy: *"Max" | "Min" | "Disabled"
			}
			scaleDown: {
				stabilizationWindowSeconds: int & >=0 | *60
				policies:                   null | *[{
					type:          "Percent"
					value:         10
					periodSeconds: 15
				}]
				selectPolicy: *"Max" | "Min" | "Disabled"
			}
		}
	}
}

// Ingress is a constrained definition of a `networking.k8s.io/v1.Ingress`.
//
// See http://go/k8s-api/service-resources/ingress-v1 for more information.
#Ingress: networking_v1.#Ingress & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
}

// Job is a constrained definition of a `batch/v1.Job`.
//
// See http://go/k8s-api/workload-resources/job-v1 for more information.
#Job: batch_v1.#Job & {
	apiVersion: "batch/v1"
	kind:       "Job"

	spec: #JobSpec
}

// Job is a constrained definition of a `batch/v1.JobSpec`.
//
// See http://go/k8s-api/workload-resources/job-v1/#JobSpec for more
// information.
#JobSpec: batch_v1.#JobSpec & {
	template: spec: #PodSpec & {
		restartPolicy: *"Never" | "OnFailure"
	}

	ttlSecondsAfterFinished: >=0 | *86400
}

// PodDisruptionBudget is a constrained definition of a
// `policy/v1.PodDisruptionBudget`.
//
// See http://go/k8s-api/policy-resources/pod-disruption-budget-v1 for more
// information.
#PodDisruptionBudget: policy_v1beta1.#PodDisruptionBudget & {
	apiVersion: "policy/v1"
	kind:       "PodDisruptionBudget"

	spec: {
		maxUnavailable: int | string | *"50%"
		minAvailable:   null
	} | {
		maxUnavailable: null
		minAvailable:   int | string | *"50%"
	}
}

// PodSpec is a constrained definition of a `core/v1.PodSpec`.
//
// See http://go/k8s-api/workload-resources/pod-v1/#PodSpec for more
// information.
#PodSpec: core_v1.#PodSpec & {
	dnsConfig: options: [{
		name:  "ndots"
		value: "2"
	}, {
		name: "single-request-reopen"
	}, ...]
	imagePullSecrets: [{
		name: "gcr-image-puller-service-account"
	}]
	securityContext: {
		runAsNonRoot: bool | *true
		runAsUser:    null | int | *10001
		runAsGroup:   null | int | *10001
		supplementalGroups: []
	}
}

// PrimaryContainer is a constrained definition of a `core/v1.Container`.
//
// The constraints here are useful only for a Pod's primary container.
//
// See http://go/k8s-api/workload-resources/pod-v1/#Container for more
// information.
#PrimaryContainer: core_v1.#Container & {
	readinessProbe: null | *{
		failureThreshold: int | *3
		httpGet: {
			path:   string | *"/health"
			port:   string | *"http"
			scheme: string | *"HTTP"
		}
		initialDelaySeconds: int | *5
		periodSeconds:       int | *10
		successThreshold:    int | *1
		timeoutSeconds:      int | *1
	}

	livenessProbe: null | *{
		failureThreshold: int | *3
		httpGet: {
			path:   string | *"/health"
			port:   string | *"http"
			scheme: string | *"HTTP"
		}
		initialDelaySeconds: int | *5
		periodSeconds:       int | *10
		successThreshold:    int | *1
		timeoutSeconds:      int | *1
	}

	resources?: {
		requests?: {
			cpu?:    number & >=0.1 & <=limits.cpu
			memory?: int & >=4Mi & <=limits.memory
		}
		limits?: {
			cpu?:    number & <=30.0
			memory?: int & <=90Gi
		}
	}

	securityContext: {
		privileged:             bool | *false
		readOnlyRootFilesystem: bool | *true
	}
}

// Resource defines a Kubernetes resource.
#Resource: {
	meta_v1.#TypeMeta

	metadata: meta_v1.#ObjectMeta

	...
}

// ResourceRequirements is a constrained definition of
// `core/v1.ResourceRequirements`.
//
// It constrains the units to the following:
// - `cpu`: `number`
// - `memory`: `int`
//
// Kubernetes allows these resources to be expressed as strings also, but in
// many cases these types are are simpler to work with, especially given that
// integer literals in CUE may be expressed with SI or IEC multipliers.
#ResourceRequirements: core_v1.#ResourceRequirements & {
	limits: {
		cpu:    number
		memory: int
	}

	requests: {
		cpu:    number
		memory: int
	}
}

// Role is a constrained definition of `rbac.authorization.k8s.io/v1.Role`.
//
// See http://go/k8s-api/authorization-resources/role-v1 for more information.
#Role: rbac_v1.#Role & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Roledestination"
}

// RoleBinding is a constrained definition of
// `rbac.authorization.k8s.io/v1.RoleBinding`.
//
// See http://go/k8s-api/authorization-resources/role-binding-v1 for more
// information.
#RoleBinding: rbac_v1.#RoleBinding & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"

	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role" | "ClusterRole"
	}
}

// Service is a constrained definition of `core/v1.Service`.
//
// See http://go/k8s-api/service-resources/service-v1 for more information.
#Service: core_v1.#Service & {
	apiVersion: "v1"
	kind:       "Service"

	spec: type: *"ClusterIP" | "ExternalName" | "NodePort" | "LoadBalancer"
}

// StatefulSet is a constrained definition of `apps/v1.StatefulSet`.
//
// See http://go/k8s-api/workload-resources/stateful-set-v1 for more
// information.
#StatefulSet: X=apps_v1.#StatefulSet & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"

	metadata: labels: {
		// Reserved labels.
		version: "main"
	}

	spec: {
		revisionHistoryLimit: int | *5

		template: {
			metadata: labels: X.metadata.labels
			spec: #PodSpec & {
				terminationGracePeriodSeconds: int & >90 | *90
			}
		}
	}
}
