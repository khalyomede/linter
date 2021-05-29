module main

import cli { Command, Flag, FlagType }
import json
import os
import linter { Linter }

fn main() {
	mut command := Command{
		name: "lint",
		usage: "lint <files> <folders>",
		description: "Check for various rules in your files.",
		version: "0.1.0",
		execute: fn(cmd Command) ? {
			if !os.exists("lint.json") {
				return error("Missing lint.json file.")
			}

			file_content := os.read_file("lint.json") ?

			linter := json.decode(Linter, file_content) ?

			errors := linter.lint()

			for error in errors {
				eprintln(error)
				println("")
			}

			if errors.len > 0 {
				exit(1)
			} else {
				exit(0)
			}
		},
		flags: [
			Flag{
				flag: FlagType.bool,
				name: "help",
				abbrev: "h",
				description: "Displays a usage guide.",
			},
			Flag{
				flag: FlagType.bool,
				name: "version",
				abbrev: "v",
				description: "Displays the version of this tool.",
			},
		]
	}

	command.parse(os.args)
}
