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
	spec: persistent: [Name=_]: #PersistentSpec & {
		name:      Name
		imageName: string | *"drizlyinc/\(metadata.name)/\(Name)"
		imageTag:  string | *"latest"
		replicas: int | *3
		env: [string]: string
		...
	}

	// let m = metadata
	_coreGen:       _
	_persistentGen: _
	k8sOutput: {
		_coreGen
		_persistentGen
	}
}
