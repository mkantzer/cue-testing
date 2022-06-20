// package kube

// import (
// 	"strings"
// 	"tool/cli"
// 	"tool/file"
// 	"encoding/yaml"
// )



// command: evaluateYaml: {
// 	// get files
// 	list: file.Glob & {
// 		glob: "*.yaml"
// 	}

// 	// comprehend tasks for each file, also an inferred dependency
// 	for _, filepath in list.files {
// 		// make a unique key for the tasks per item
// 		files: (filepath): {
// 			// and have locally referenced dependencies
// 			read: file.Read & {
// 				filename: filepath
// 				// contents: string 
// 			}

// 			yamlStream: yaml.UnmarshalStream(read.contents)
// 			yamlStream: [...#Schema]
// 		}
// 	}

// 	ls: cli.Print & {
// 		let Lines = [
// 			for x in objects {
// 				"\(x.kind)  \t\(x.metadata.name)"
// 			},
// 		]
// 		text: strings.Join(Lines, "\n")
// 	}
// }

// [ for _, file in command.evaluateYaml.files {
// 	[ for _, object in file.yamlStream {
// 		"\(strings.ToCamel(object.kind))": "\(object.metadata.Name)": object
// 	}]
// },
// ]
