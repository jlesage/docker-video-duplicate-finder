# Docker container for Video Duplicate Finder
[![Release](https://img.shields.io/github/release/jlesage/docker-video-duplicate-finder.svg?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-video-duplicate-finder/releases/latest)
[![Docker Image Size](https://img.shields.io/docker/image-size/jlesage/video-duplicate-finder/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/video-duplicate-finder/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/jlesage/video-duplicate-finder?label=Pulls&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/video-duplicate-finder)
[![Docker Stars](https://img.shields.io/docker/stars/jlesage/video-duplicate-finder?label=Stars&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/video-duplicate-finder)
[![Build Status](https://img.shields.io/github/actions/workflow/status/jlesage/docker-video-duplicate-finder/build-image.yml?logo=github&branch=master&style=for-the-badge)](https://github.com/jlesage/docker-video-duplicate-finder/actions/workflows/build-image.yml)
[![Source](https://img.shields.io/badge/Source-GitHub-blue?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-video-duplicate-finder)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg?style=for-the-badge)](https://paypal.me/JocelynLeSage)

This is a Docker container for [Video Duplicate Finder](https://github.com/0x90d/videoduplicatefinder).

The GUI of the application is accessed through a modern web browser (no
installation or configuration needed on the client side) or via any VNC client.

---

[![Video Duplicate Finder logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/video-duplicate-finder-icon.png&w=110)](https://github.com/0x90d/videoduplicatefinder)[![Video Duplicate Finder](https://images.placeholders.dev/?width=704&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=Video%20Duplicate%20Finder&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://github.com/0x90d/videoduplicatefinder)

Video Duplicate Finder is a cross-platform software to find duplicated video (and
image) files on hard disk based on similiarity.  That means unlike other duplicate
finders, this one does also finds duplicates which have a different resolution,
frame rate and even watermarked.

---

## Quick Start

**NOTE**:
    The Docker command provided in this quick start is given as an example
    and parameters should be adjusted to your need.

Launch the Video Duplicate Finder docker container with the following command:
```shell
docker run -d \
    --name=video-duplicate-finder \
    -p 5800:5800 \
    -v /docker/appdata/video-duplicate-finder:/config:rw \
    -v /home/user:/storage:rw \
    jlesage/video-duplicate-finder
```

Where:

  - `/docker/appdata/video-duplicate-finder`: This is where the application stores its configuration, states, log and any files needing persistency.
  - `/home/user`: This location contains files from your host that need to be accessible to the application.

Browse to `http://your-host-ip:5800` to access the Video Duplicate Finder GUI.
Files from the host appear under the `/storage` folder in the container.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-video-duplicate-finder.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-video-duplicate-finder/issues
