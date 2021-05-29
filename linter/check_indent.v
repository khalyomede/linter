module linter

fn check_indent(lines []string, indent_style IndentStyle) []string {
	mut errors := []string{}
	mut line_number := 1

	for line in lines {
		wrong_character := match indent_style {
			.tab {
				" "
			}

			.space {
				"\t"
			}

			.any {
				""
			}
		}

		good_character := match indent_style {
			.tab {
				"tab"
			}

			.space {
				"space"
			}

			.any {
				"any"
			}
		}

		if line.starts_with(wrong_character) {
			errors << '$line_number:0: Line must start with $good_character (indent_style)\n  $line'
		}

		line_number += 1
	}

	return errors
}
