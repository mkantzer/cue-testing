package kube

import (
	// "text/tabwriter"
	"strings"
	"tool/cli"
	// "tool/exec"
	"tool/file"
)



command: importYaml: {
// This is defffff wrong. The correct way to handle this:
// - expect it to be run _in_ the target directory, not _at_
// - I probably don't need to actually call the `cue` binary.
// - I can almost certainly _directly read_ the contents of YAML files, and then use them directly as YAML streams. 
// - can _probably_ also set them to some kind of value based on their contents.
// - can then also write the output to file(s)
// - can prob also use this basic plan for standardizing _cue vet_?


// START WRONG
	glob: file.Glob & {
		glob: "*.yaml"
		files: [...string]
	}

	 display: cli.Print & {
	  text: "Found Files:\n" + strings.Join(glob.files, "\n")
	 }

	//  read: file.Read & {
	// 	filename: 
	//  }


	// task: import: exec.Run & {
	// 	cmd: "cue import -f -l strings.ToCamel(kind) -l metadata.name  -p kube \(strings.Join(task.glob.files, " "))"
	// }
// EOF WRONG
}
