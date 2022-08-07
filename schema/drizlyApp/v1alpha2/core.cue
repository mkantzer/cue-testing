package v1alpha2

import (
	core_v1 "k8s.io/api/core/v1"
)

#DrizlyApp: {
	metadata: _
	spec:     _

	let m = metadata
	_coreGen: namespace: "\(m.name)": core_v1.#Namespace & {
		metadata: m
	}
}
