package kube

ingress: [ID=_]: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		name: ID
		labels: {
			app:       ID         // by convention
			component: #Component // varies per directory
		}
	}
	spec: {
    ingressClassName: "nginx"
		// Any port has the following properties.
    rules: [
      http: paths: [{
        path: string
        pathType: "Prefix"
        backend: service: {
          name: ID
          port: number: int
        }
      }]
    ]
	}
}