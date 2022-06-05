package kube

import (
	// "text/tabwriter"
	"strings"
	// "tool/cli"
	"tool/exec"
	"tool/file"
)

command: importYaml: {
 task: glob: file.Glob & {
  glob: "*.yaml"
  files: [...string]
 }

//  task: display: {
//   kind: "print"
//   text: "Found Files:\n" + strings.Join(task.glob.files, "\n")
//  }

 task: import: exec.Run & {
  cmd: "cue import -f -l strings.ToCamel(kind) -l metadata.name  -p kube \(strings.Join(task.glob.files, " "))"
 }
}
