#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Install default config file if no one exists.
[ -f /config/Settings.json ] || cp /defaults/Settings.json /config/Settings.json

# Handle dark mode.
if is-bool-val-true "${DARK_MODE:-0}"; then
    DARKMODE_VAL="true"
else
    DARKMODE_VAL="false"
fi
jq -c -M ".DarkMode = $DARKMODE_VAL" /config/Settings.json | sponge /config/Settings.json

# vim:ft=sh:ts=4:sw=4:et:sts=4
