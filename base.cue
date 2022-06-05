package kube

// defines the base schema every object needs to have.
_base: {
	name: string
	label: [string]: string
	label: {
		app:       name
		domain:    "local" | "integration" | "production"
		component: string
	}
}
