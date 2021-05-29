# linter

Check your .v files for various rules.

## Summary

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Examples](#examples)
- [Available rules](#available-rules)
- [Known issues](#known-issues)
- [Test](#test)

## About

I created this library to be able to configure rules that fits my code style and lint my files.

## Features

- Can lint folders (only .v files) or files
- Provides several configurable [rules](#available-rules)

## Installation

```bash
v install khalyomede.linter
```

## Examples

- [1. Lint files](#1-lint-files)
- [2. Lint folders](#2-lint-folders)
- [3. Use the command line tool](#3-use-the-command-line-tool)

### 1. Lint files

In this example, we will lint v files.

```v
import khalyomede.linter

fn main() {
  lint_runner := Linter{
    files: [
      "index.v",
      "function.v",
    ],
    rules: {
      end_new_line: true,
      no_trailing_whitespace: true,
    }
  }

  errors := lint_runner.lint()

  for error in errors {
    println(error)
    println("")
  }
}
```

### 2. Lint folders

In this example, we will lint files on a folder.

```v
import khalyomede.linter

fn main() {
  lint_runner := Linter{
    folders: [
      "src",
      "lib/function",
    ],
  }

  errors := lint_runner.lint()

  for error in errors {
    println(error)
    println("")
  }
}
```

### 3. Use the command line tool

In this example, you will see how to compile the command line tool and use it to lint your files.

First of all, check the known issue about [no executables for Windows and MacOS](#no-executables-for-windows-and-mac-os) if you are on Windows or MacOS. If you are on linux, you can run the executable from `/root/.vmodules/khalyomede/linter/cmd/lint`.

Next, create a `lint.json` file, which has a similar configuration as you can see in the 2 previous examples:

```json
{
  "files": [
    "index.v",
    "other-file.v",
  ],
  "rules": {
    "end_new_line": true,
    "no_trailing_whitespace": true
  }
}
```

Then, run the command on your folder, and you should see your lint errors on the console.

## Available rules

Rules starting with ⚡ mean they don't rely on parsing an [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree), which improves their speed.

- [⚡ end_new_line](#end_new_line)
- [⚡ indent_style](#indent_style)
- [⚡ no_empty_line](#no_empty_line)
- [⚡ no_trailing_whitespace](#no_trailing_whitespace)

### end_new_line

Asserts that the file ends with an end new line. Default to `true`.

```v
struct Rules {
  end_new_line bool = true
}
```

### indent_style

Asserts that the lines are indented with the given indent character. Default to `IndentStyle.tab`.

```v
enum IndentStyle {
  tab
  space
}

struct Rules {
  indent_style IndentStyle = IndenStyle.tab
}
```

### no_empty_line

Asserts that there is no 2 or more lines empty. Default to `true`.

```v
struct Rules {
  no_empty_line bool = true
}
```

### no_trailing_whitespace

Asserts that the lines in a file do not ends with a whitespace. Default to `true`.

```v
struct Rules {
  no_trailing_whitespace bool = true
}
```

## Known issues

- [Compiling the command](#compiling-the-command)
- [Command line path](#command-line-path)
- [No executables for Windows and MacOS](#no-executables-for-windows-and-mac-os)

### Compiling the command

This is a development issue, not an end user issue.

For the moment I cannot know why the file command.v cannot find files with module linter in the root of the folder: I have to copy all of them to a folder named linter, for the import to work.


### Command line path

For the moment to run the executable, you need to use the full `/root/.vmodules/khalyomede/linter/cmd/lint` path, which is little convenient.

I did not figured out how to make this better so that it is present in your global executable path so that you can just call it by its name.

### No executables for Windows and MacOS

For the moment, there is only a Linux executable. I tried to compile for Windows (I develop on a Windows 10), but when I try to run the executable, I have an issue:

```bash
docker-compose run v -os windows -arch x86 -o cmd/lint command.v
```

```bash
$ ./cmd/lint.exe
bash: ./cmd/lint.exe : unable to execute binary file : Format error for exec()
```

You can try to compile with v (which will figure out your os and architecture automatically) if you want to give it a try:

```bash
$ cd /path-to-your-v-modules/khalyomede/linter
$ v -prod -prealloc -o /wherever-you-want/lint command.v
```

## Test

```v
v test .
```
