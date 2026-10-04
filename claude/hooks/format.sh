#!/bin/sh
# Ruby is left alone because projects pick their own style (RuboCop, Standard).

ends_with_newline() {
  [ "$(tail -c 1 "$1")" = "" ]
}

path=$(jq -r '.tool_input.file_path // empty')
[ -f "$path" ] || exit 0

if [ -s "$path" ] && ! ends_with_newline "$path"; then
  echo >> "$path"
fi

case "$path" in
  *.tf | *.tfvars) terraform fmt "$path" > /dev/null ;;
esac
