module linter

fn check_no_trailing_whitespace(lines []string) []string {
	mut errors := []string{}
	mut line_number := 1

	for line in lines {
		if line.ends_with(" ") {
			column := line.len -1

			errors << '$line_number:$column: Line must not contain trailing whitespace (no_trailing_whitespace)\n  $line'
		}

		line_number += 1
	}

	return errors
}
