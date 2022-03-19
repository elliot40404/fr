# FR - find and replace

```sh
    __________
   / ____/ __ \
  / /_  / /_/ /
 / __/ / _, _/
/_/   /_/ |_|
fr - Find and Replace in files
Version: 0.1.0
```

- [Table of Contents](#fr---find-and-replace)
  - [Features](#features)
  - [Upcoming features](#upcoming-features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Examples](#examples)

## Features

- [x] Find and replace text in files
- [x] Find and replace text in files with regex recursively
- [x] Find and replace text in files with specific extensions

## Upcoming features

- [x] Ability to exclude directories
- [x] Ability to exclude files with specific extensions/names
- [x] Ability to install with package managers

## Installation

```sh
git clone https://github.com/elliot40404/fr
cd fr
chmod +x install.sh
./install.sh
```

or

```sh
sudo curl -o- https://raw.githubusercontent.com/elliot40404/fr/master/install.sh | bash
```

```sh
sudo wget -qO- https://raw.githubusercontent.com/elliot40404/fr/master/install.sh | bash
```

## Usage

```sh
fr [directory]* [pattern]* [new_value]* [extension] [deep]
```

> \* = Required argument

| Argument                   | Description                               | Required |  Default  |
| -------------------------- | :---------------------------------------- | :------: | :-------: |
| first argument [directory] | The directory to search in                |   yes    |   none    |
| second argument [pattern]  | The pattern to search for                 |   yes    |   none    |
| third argument [new_value] | The new value to replace the pattern with |   yes    |   none    |
| -e, --extension            | files with extension to search for        |    no    | All files |
| -d, --deep                 | Whether to search in subdirectories       |    no    |   false   |
| -h, --help                 | Print help menu                           |          |           |

## Examples

Replace foo with bar in all files in the current directory:

```sh
fr . "foo" "bar"
```

Replace foo with bar in all files in the test directory:

```sh
fr test/ "foo" "bar"
```

Replace foo with bar in all javascript files in the test directory:

```sh
fr test/ "foo" "bar" -e js
```

Replace foo with bar in all files in the test directory and its subdirectories:

```sh
fr test/ "foo" "bar" -d
```

Replace foo with bar in all javascript files in the test directory and its subdirectories:

```sh
fr test/ "foo" "bar" -e js -d
```

## License

MIT
