package kubeButYAML

import (
	"tool/cli"
	"tool/file"
	"encoding/yaml"
)

command: validateYAML: {
	// get files
	list: file.Glob & {
		glob: "*.yaml"
	}

	// comprehend tasks for each file, also an inferred dependency
	for _, filepath in list.files {
		// make a unique key for the tasks per item
		files: (filepath): {
			// and have locally referenced dependencies
			read: file.Read & {
				filename: filepath
				// contents: string 
			}

			yamlStream: yaml.UnmarshalStream(read.contents)
			yamlStream: [...#Schema]

			print: cli.Print & {
				text: "\(filepath)\tvalid"
			}
		}
	}
}
