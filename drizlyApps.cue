package kube

import (
	drizlyApp_v1alpha1 "github.com/mikekantzer-drizly/cue-testing/schema/drizlyApp/v1alpha1"
)

drizlyApp: drizlyApp_v1alpha1.#DrizlyApp // | drizlyApp_v1alpha2.#DrizlyApp

kubernetes: drizlyApp.k8sOutput
