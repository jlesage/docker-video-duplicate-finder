#
# video-duplicate-finder Dockerfile
#
# https://github.com/jlesage/docker-video-duplicate-finder
#

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG VIDEO_DUPLICATE_FINDER_COMMIT_SHA=1808f81
ARG VIDEO_DUPLICATE_FINDER_VERSION=3.0.x-${VIDEO_DUPLICATE_FINDER_COMMIT_SHA}
ARG FFMPEG_VERSION=7.1.1

# Define software download URLs.
ARG VIDEO_DUPLICATE_FINDER_URL=https://github.com/0x90d/videoduplicatefinder/archive/${VIDEO_DUPLICATE_FINDER_COMMIT_SHA}.tar.gz
ARG FFMPEG_URL=https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz

# Get Dockerfile cross-compilation helpers.
FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

# Build Video Duplicate Finder.
FROM --platform=$BUILDPLATFORM alpine:3.21 AS vdf
ARG TARGETPLATFORM
ARG VIDEO_DUPLICATE_FINDER_URL
COPY --from=xx / /
COPY src/vdf /build
RUN /build/build.sh "$VIDEO_DUPLICATE_FINDER_URL"
RUN xx-verify /tmp/vdf-install/VDF.GUI

# Build FFmpeg.
FROM --platform=$BUILDPLATFORM alpine:3.21 AS ffmpeg
ARG TARGETPLATFORM
ARG FFMPEG_URL
COPY --from=xx / /
COPY src/ffmpeg /build
RUN /build/build.sh "$FFMPEG_URL"
RUN xx-verify \
    /tmp/ffmpeg-install/usr/bin/ffmpeg \
    /tmp/ffmpeg-install/usr/bin/ffplay \
    /tmp/ffmpeg-install/usr/bin/ffprobe \
    /tmp/ffmpeg-install/usr/lib/lib*.so.*

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.21-v4.10.6

ARG TARGETARCH
ARG VIDEO_DUPLICATE_FINDER_VERSION
ARG DOCKER_IMAGE_VERSION

# Define working directory.
WORKDIR /tmp

# Install dependencies.
RUN \
    [ "${TARGETARCH:-amd64}" = "amd64" ] && _onevpl=onevpl-libs || _onevpl=; \
    add-pkg \
        gtk+3.0 \
        icu-libs \
        libice \
        libsm \
        libunwind \
        sdl2 \
        libdrm \
        libpulse \
        libva \
        libvdpau \
        $_onevpl \
        adwaita-icon-theme \
        font-dejavu \
        pcmanfm \
        jq \
        # Need for the `sponge` tool.
        moreutils

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/video-duplicate-finder-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=vdf /tmp/vdf-install /opt/vdf
COPY --from=ffmpeg /tmp/ffmpeg-install/usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg /tmp/ffmpeg-install/usr/bin/ffplay /usr/bin/ffplay
COPY --from=ffmpeg /tmp/ffmpeg-install/usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=ffmpeg /tmp/ffmpeg-install/usr/lib /usr/lib

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "Video Duplicate Finder" && \
    set-cont-env APP_VERSION "$VIDEO_DUPLICATE_FINDER_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Define mountable directories.
VOLUME ["/storage"]

# Metadata.
LABEL \
      org.label-schema.name="video-duplicate-finder" \
      org.label-schema.description="Docker container for Video Duplicate Finder" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-video-duplicate-finder" \
      org.label-schema.schema-version="1.0"
