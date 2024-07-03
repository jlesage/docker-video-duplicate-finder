#
# video-duplicate-finder Dockerfile
#
# https://github.com/jlesage/docker-video-duplicate-finder
#

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG VIDEO_DUPLICATE_FINDER_COMMIT_SHA=1d93ac0
ARG VIDEO_DUPLICATE_FINDER_VERSION=3.0.x-${VIDEO_DUPLICATE_FINDER_COMMIT_SHA}

# Define software download URLs.
ARG VIDEO_DUPLICATE_FINDER_URL=https://github.com/0x90d/videoduplicatefinder/archive/${VIDEO_DUPLICATE_FINDER_COMMIT_SHA}.tar.gz

# Get Dockerfile cross-compilation helpers.
FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

# Build Video Duplicate Finder.
FROM --platform=$BUILDPLATFORM alpine:3.17 AS vdf
ARG TARGETPLATFORM
ARG VIDEO_DUPLICATE_FINDER_URL
COPY --from=xx / /
COPY src/vdf /build
RUN /build/build.sh "$VIDEO_DUPLICATE_FINDER_URL"
RUN xx-verify /tmp/vdf-install/VDF.GUI

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.17-v4.6.3

ARG VIDEO_DUPLICATE_FINDER_VERSION
ARG DOCKER_IMAGE_VERSION

# Define working directory.
WORKDIR /tmp

# Install dependencies.
RUN add-pkg \
        gtk+3.0 \
        icu-libs \
        libice \
        libsm \
        adwaita-icon-theme \
        font-dejavu \
        ffmpeg \
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
