#!/bin/sh
printf '\033c\033]0;%s\a' Chapter 2 Countdown
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Chapter 2 Countdown.x86_64" "$@"
