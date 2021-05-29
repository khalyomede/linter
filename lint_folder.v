module linter

import os

fn lint_folder(folder string, rules Rules) []string {
	mut errors := []string{}

	mut files := os.ls(folder) or { [] }
	files = files.filter(it.ends_with(".v"))

	for file in files {
		file_path := os.join_path(folder, file)

		errs := lint_file(file_path, rules)

		if errs.len > 0 {
			for err in errs {
				errors << err
			}
		}
	}

	return errors
}
