package v1alpha2

// import (
//  core_v1 "k8s.io/api/core/v1"
// )

drizlyApp: #DrizlyApp

#DrizlyAppMetadata: {
	name: string
	labels: [string]: string
	labels: {
		app:  name
		repo: string
		team: string
	}
}

#DrizlyApp: {
	apiVersion: "v1alpha2"
	kind:       "DrizlyApp"
	metadata:   #DrizlyAppMetadata

	// let m = metadata
	_coreGen: {}
	k8sOutput: {
		_coreGen
	}
}
