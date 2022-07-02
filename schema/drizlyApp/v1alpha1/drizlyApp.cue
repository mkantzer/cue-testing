package v1alpha1

#DrizlyApp: {
	apiVersion: "v1alpha1"
	kind:       "DrizlyApp"
	metadata: {
		name: string
		labels: [string]: string
		labels: {
			repo: string
			team: string
			...
		}
	}
	spec: {
		always: [Name=_]: {
			replicas:  *3 | int
			imageName: "drizlyinc/\(metadata.name)/\(Name)"
			imageTag:  string | *"latest"
			env: [Key=_]: string
      networking: [PortName=_]: {
        public: bool | *false
        port: int | *80
        path: "/"
      }
		}
    jobs: [Job=_]: {
      trigger: "preDeploy" | "cron" | "manual" | "event"
      imageName: "drizlyinc/\(metadata.name)/\(Job)"
      imageTag: string | *"latest"
      env: [Key=_]: string
    }
		backingServices: [{
			type: "postgres" | "s3" | "redis"
		}]
	}
}
