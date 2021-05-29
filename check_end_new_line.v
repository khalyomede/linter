module linter

fn check_end_new_line(content string) []string {
	if content.len == 0 {
		return []
	}

	characters := content.split("")
	last_character := characters[characters.len -1]

	if last_character == "\n" {
		return []
	}

	return [" Missing end new line (end_new_line)"]
}
