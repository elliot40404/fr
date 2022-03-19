#!/usr/bin/env bash

##   _____ ____  
##  |  ___|  _ \
##  | |_  | |_) |
##  |  _| |  _ <
##  |_|   |_| \_\
##  https://github.com/elliot40404
##  by @Elliot40404

VERSION="0.1.0"
DIR=$1       # > Directory to scan
PATTERN=$2   # > Pattern to search
NEW_VALUE=$3 # > New value to replace

CMD="find $DIR -maxdepth 1 -type f"

VALID_ARGS=$(getopt -o hde: --long help,deep,extension: -- "$@")

### INVALID ARGS
if [[ $? -ne 0 ]]; then
    echo "Invalid arguments"
    echo "FR Help:"
    echo -e "\e[1mUsage: fr <directory>* <pattern>* <new value>* [extension] [deep]\e[0m"
    echo -e "\e[1m* Required parameters\e[0m"
    echo "-e, --extension search files with this extension (default: all)"
    echo "-d, --deep      search files in subdirectories (default: no)"
    exit 1
fi
### NO ARGS
if [[ -z "$@" ]]; then
    if hash lolcat 2>/dev/null && hash figlet 2>/dev/null; then
        figlet -f slant "F R" | lolcat -p 6.0
    fi
    echo -e "\033[1;35mfr - Find and replace in files\033[0m"
    echo -e "\033[1;36mVersion: $VERSION\033[0m"
    echo "FR Help:"
    echo -e "\e[1mUsage: fr <directory>* <pattern>* <new value>* [extension] [deep]\e[0m"
    echo -e "\e[1m* Required parameters\e[0m"
    echo "-e, --extension search files with this extension (default: all)"
    echo "-d, --deep      search files in subdirectories (default: no)"
    echo "Example:"
    echo -e "1. \e[1mfr dirname cat tac\e[0m"
    echo -e "2. \e[1mfr dirname console\.log console\.dir -e js\e[0m"
    echo -e "3. \e[1mfr dirname console\.log console\.dir --extension js --deep\e[0m"
    exit 1
fi

eval set -- "$VALID_ARGS"

while [ : ]; do
    case "$1" in
    -h | --help)
        if hash lolcat 2>/dev/null && hash figlet 2>/dev/null; then
            figlet -f slant "F R" | lolcat -p 6.0
        fi
        echo -e "\033[1;35mfr - Find and replace in files\033[0m"
        echo -e "\033[1;36mVersion: $VERSION\033[0m"
        echo "FR Help:"
        echo -e "\e[1mUsage: fr <directory>* <pattern>* <new value>* [extension] [deep]\e[0m"
        echo -e "\e[1m* Required parameters\e[0m"
        echo "-h, --help      print this help"
        echo "-e, --extension search files with this extension (default: all)"
        echo "-d, --deep      search files in subdirectories (default: no)"
        echo "Example:"
        echo -e "1. \e[1mfr dirname cat tac\e[0m"
        echo -e "2. \e[1mfr dirname console\.log console\.dir -e js\e[0m"
        echo -e "3. \e[1mfr dirname console\.log console\.dir --extension js --deep\e[0m"
        shift
        ;;
    -d | --deep)
        CMD=$(echo $CMD | sed "s/-maxdepth\s1//")
        shift
        ;;
    -e | --extension)
        CMD="$CMD -name \"*.$2\""
        shift 2
        ;;
    --)
        shift
        break
        ;;
    esac
done

CMD="$CMD | xargs sed -i \"s/$PATTERN/$NEW_VALUE/gm\""
eval $CMD