module linter

pub struct Rules {
	indent_style IndentStyle = IndentStyle.tab
	no_trailing_whitespace bool = true
	no_empty_line bool = true
	end_new_line bool = true
}
