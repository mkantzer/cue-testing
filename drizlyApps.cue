package kube

import (
	drizlyApp_v1alpha1 "github.com/mikekantzer-drizly/cue-testing/schema/drizlyApp/v1alpha1"
)

drizlyApp: drizlyApp_v1alpha1.#DrizlyApp

for a in drizlyApp.spec.always {
	kubernetes: {
		deployment: "\(drizlyApp.metadata.name)-\(a.name)": {
      metadata: labels: {
        repo: drizlyApp.metadata.labels.repo
        team: drizlyApp.metadata.labels.team
        env: drizlyApp.metadata.labels.env
      }
      spec: {
        replicas: a.replicas

        TODO: Continue Doing This!!!!!
      }
		}
	}
}
