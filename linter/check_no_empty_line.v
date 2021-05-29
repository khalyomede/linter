module linter

fn check_no_empty_line(lines []string, check_last_line bool) []string {
	mut errors := []string{}
	mut line_number := 1
	last_line_number := lines.len - 1
	mut previous_line_empty := false

	for line in lines {
		if last_line_number == line_number && !check_last_line {
			continue
		}

		if line.split("").filter(it == " ").len == line.len {
			if previous_line_empty {
				errors << '$line_number:0: No empty lines (no_empty_line)'
			} else {
				previous_line_empty = true
			}
		} else {
			previous_line_empty = false
		}

		line_number += 1
	}

	return errors
}
