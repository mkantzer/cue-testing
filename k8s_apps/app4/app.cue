package kube

mikeApp: {
	metadata: {
		name: "app4"
		labels: {
			repo: "mkantzer/hello"
			team: "hades"
		}
	}
	spec: {
		always: app: {
			imageTag: "kasjafdgbjioaw"
      replicas: 3
			env: {
				APP_WHATEVER: "okayFine"
				APP_ENV:      metadata.labels.env
			}
			networking: ingress: {
				public:     true
				port:       8080
				publicPath: "/app4"
			}
		}
		jobs: migrator: {
			trigger:  "preDeploy"
			imageTag: "kasjafdgbjioaw"
		}
		backingServices: db: type: "postgres"
	}
}
