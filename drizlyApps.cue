package kube

import (
	drizlyApp_v1alpha1 "github.com/mikekantzer-drizly/cue-testing/schema/drizlyApp/v1alpha1"
	drizlyApp_v1alpha2 "github.com/mikekantzer-drizly/cue-testing/schema/drizlyApp/v1alpha2"
)

drizlyApp: _

if drizlyApp.apiVersion == "v1alpha1" {
	drizlyApp: drizlyApp_v1alpha1.#DrizlyApp
}
if drizlyApp.apiVersion == "v1alpha2" {
	drizlyApp: drizlyApp_v1alpha2.#DrizlyApp
}

kubernetes: drizlyApp.k8sOutput
