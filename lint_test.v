module test

import linter { Linter }

fn test_indent_style_tab() {
	params := Linter{
		files: [
			"misc/indent_space.v"
		]
	}

	assert params.lint() == ['misc/indent_space.v:4:0: Line must start with tab (indent_style)\n      return "hello world"']
}

fn test_no_trailing_whitespace() {
	params := Linter{
		files: [
			"misc/trailing_whitespace.v"
		]
	}

	assert params.lint() == ['misc/trailing_whitespace.v:3:15: Line must not contain trailing whitespace (no_trailing_whitespace)\n  fn b() string { ']
}

fn test_lint_on_files_of_folder() {
	params := Linter{
		folders: [
			"misc/folder"
		]
	}

	assert params.lint() == ['misc/folder/indent_space.v:4:0: Line must start with tab (indent_style)\n      return "hello world"']
}

fn test_empty_lines() {
	params := Linter{
		files: [
			"misc/empty_line.v",
		],
	}

	errors := params.lint()

	assert errors == ['misc/empty_line.v:3:0: No empty lines (no_empty_line)']
}

fn test_end_new_line() {
	params := Linter{
		files: [
			"misc/end_new_line.v",
		]
	}

	errors := params.lint()

	assert errors == ["misc/end_new_line.v: Missing end new line (end_new_line)"]
}
