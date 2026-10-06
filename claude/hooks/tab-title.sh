#!/bin/sh
# Hooks run without a controlling terminal, so /dev/tty is unavailable.
# Write to the tty of the nearest ancestor that has one, which is the claude process.

icon=$1
transcript=$(jq -r '.transcript_path // empty')

# Claude Code records the topic it would show in the title as ai-title, but only after the first reply.
title=$(grep '"type":"ai-title"' "$transcript" 2>/dev/null | tail -n 1 | jq -r '.aiTitle')
[ -n "$title" ] || title=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")

pid=$PPID
while [ "$pid" -gt 1 ]; do
  tty=$(ps -o tty= -p "$pid" | tr -d ' ')
  if [ -n "$tty" ] && [ "$tty" != "??" ]; then
    printf '\033]2;%s\007' "${icon:+$icon }$title" > "/dev/$tty"
    exit 0
  fi
  pid=$(ps -o ppid= -p "$pid" | tr -d ' ')
done
