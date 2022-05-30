// Package drizly contains definitions specific to Drizly infrastructure.
package drizly

// Cluster specifies a Drizly Kubernetes cluster.
#Cluster:
	#localApp | #localTool
  #devApp01 | #devApp02 | #devTool01 | #devTool02
  #integraion01 | #integraion02
  #prod01 | #prod02 | #prod03

// Environment specifies a Drizly environment (short-form).
#Env:
	#Dev | #Int | #Prod

// Environment specifies a Drizly environment (long-form).
#Environment:
	#Development | #Integration | #Production

// AWSRegion specifies an AWS region.
#AWSRegion:
	#usEast1 | #usWest2


