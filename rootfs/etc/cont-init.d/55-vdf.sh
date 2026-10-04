#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Install default config file if no one exists.
[ -f /config/Settings.json ] || cp /defaults/Settings.json /config/Settings.json

# Handle dark mode.
# ThemeMode: 1 = Light, 2 = Dark. DarkMode is the legacy switch and is ignored
# once ThemeMode is set.
if is-bool-val-true "${DARK_MODE:-0}"; then
    THEME_VAL=2
else
    THEME_VAL=1
fi
jq -c -M "del(.DarkMode) | .ThemeMode = $THEME_VAL" /config/Settings.json | sponge /config/Settings.json

# vim:ft=sh:ts=4:sw=4:et:sts=4
