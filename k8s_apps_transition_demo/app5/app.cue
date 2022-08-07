package kube

drizlyApp: {
	apiVersion: "v1alpha2"
	kind:       "DrizlyApp"
	metadata: {
		name: "app5"
		labels: {
			repo: "cue-testing"
			team: "justMike"
		}
	}
}
