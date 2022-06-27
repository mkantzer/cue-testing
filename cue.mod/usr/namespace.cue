package kube

namespace: [ID=_]: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		name: ID
		labels: {
			app:       ID         // by convention
			component: #Component // varies per directory
		}
	}
}