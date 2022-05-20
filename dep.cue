apiVersion: "apps/v1"
kind:       "Deployment"
metadata: name: "hello-kubernetes"
spec: {
	replicas: 3
	selector: matchLabels: app: "hello-kubernetes"
	template: {
		metadata: labels: app: "hello-kubernetes"
		spec: containers: [{
			name:  "hello-kubernetes"
			image: "nginx:latest"
			ports: [{
				containerPort: 8080
			}]
		}]
	}
}
