#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() {
    echo ">>> $*"
}

VIDEO_DUPLICATE_FINDER_URL="${1:-}"

if [ -z "$VIDEO_DUPLICATE_FINDER_URL" ]; then
    log "ERROR: Video Duplicate Finder URL missing."
    exit 1
fi

#
# Install required packages.
#
apk --no-cache add \
    curl \
    patch \
    dotnet9-sdk \

#
# Download sources.
#

log "Downloading Video Duplicate Finder package..."
mkdir /tmp/vdf
curl -# -L -f ${VIDEO_DUPLICATE_FINDER_URL} | tar xz --strip 1 -C /tmp/vdf

#
# Compile Video Duplicate Finder.
#

log "Patching Video Duplicate Finder..."
PATCHES="\
    disable-appearance-settings.patch \
    disable-latest-release.patch \
    disable-drag-and-drop-hint.patch \
    set-current-folder.patch \
    file-picker-suggested-start-location.patch \
"
for PATCH in $PATCHES; do
    echo "Applying $PATCH..."
    patch -p1 -d /tmp/vdf < "$SCRIPT_DIR"/"$PATCH"
done

# Determine the dotnet arch.
case "$(xx-info arch)" in
    amd64) dotnet_arch=x64;;
    arm64) dotnet_arch=arm64;;
    arm) dotnet_arch=arm;;
    *) echo "ERROR: Unsupported arch: $(xx-info arch)." && exit 1;;
esac

log "Building Video Duplicate Finder..."
(
    cd /tmp/vdf && \
    dotnet nuget add source https://www.myget.org/F/sixlabors/api/v3/index.json
    dotnet publish -c Release --self-contained -r "linux-musl-$dotnet_arch" -o /tmp/vdf-install
)
