module linter

import os

fn lint_file(file_path string, rules Rules) []string {
	mut errors := []string{}

	mut lines := []string{}
	mut content := ""

	mut errs := []string{}

	if rules.indent_style != IndentStyle.any {
		if lines == [] {
			lines = os.read_lines(file_path) or {
				panic(err)
			}
		}

		errs = linter.check_indent(lines, rules.indent_style)

		if errs.len > 0 {
			for err in errs {
				errors << '$file_path:$err'
			}
		}
	}

	if rules.no_trailing_whitespace {
		if lines == [] {
			lines = os.read_lines(file_path) or {
				panic(err)
			}
		}

		errs = linter.check_no_trailing_whitespace(lines)

		if errs.len > 0 {
			for err in errs {
				errors << '$file_path:$err'
			}
		}
	}

	if rules.no_empty_line {
		if lines == [] {
			lines = os.read_lines(file_path) or {
				panic(err)
			}
		}

		errs = linter.check_no_empty_line(lines, !rules.end_new_line)

		if errs.len > 0 {
			for err in errs {
				errors << '$file_path:$err'
			}
		}
	}

	if rules.end_new_line {
		if content == "" {
			content = os.read_file(file_path) or {
				panic(err)
			}
		}
		errs = linter.check_end_new_line(content)

		if errs.len > 0 {
			for err in errs {
				errors << '$file_path:$err'
			}
		}
	}

	return errors
}
