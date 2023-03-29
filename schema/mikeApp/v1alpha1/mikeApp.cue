package v1alpha1

#MikeApp: {
	apiVersion: "v1alpha1"
	kind:       "MikeApp"
	metadata: {
		name: string
		labels: [string]: string
		// these might be better as annotations:
		labels: {
			name: metadata.name
			repo: string
			team: string
			env: "local" | "integration" | "production"
			...
		}
	}
	spec: {
		always: [Name=_]: {
			name: Name
			replicas:  *3 | int
			imageName: "mkantzer/\(metadata.name)/\(Name)"
			imageTag:  string | *"latest"
			env: [Key=_]: string
      networking: [PortName=_]: {
        public: bool | *false
        port: int | *80
        publicPath: string | *"/"
      }
		}
    jobs: [Job=_]: {
      trigger: "preDeploy" | "cron" | "manual" | "event"
      imageName: "mkantzer/\(metadata.name)/\(Job)"
      imageTag: string | *"latest"
			cmd: string | *"up"
      env: [Key=_]: string
    }
		backingServices: [BackingName=_]: {
			type: "postgres" | "s3" | "redis"
		}
	}
}
