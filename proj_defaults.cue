package kube

// This file defines our project-specific labels to apply to everything
_base: {
	name: string
	label: {
		app:       name
		domain:    "prod"
		component: string
	}
}
