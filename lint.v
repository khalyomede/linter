module linter

pub fn (configuration Linter) lint() []string {
	mut errors := []string{}

	if configuration.files.len > 0 {
		for file in configuration.files {
			errs := linter.lint_file(file, configuration.rules)

			if errs.len > 0 {
				for err in errs {
					errors << err
				}
			}
		}
	} else if configuration.folders.len > 0 {
		for folder in configuration.folders {
			errs := linter.lint_folder(folder, configuration.rules)

			if errs.len > 0 {
				for err in errs {
					errors << err
				}
			}
		}
	}

	return errors
}
