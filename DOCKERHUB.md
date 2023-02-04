# Docker container for Video Duplicate Finder
[![Docker Image Size](https://img.shields.io/docker/image-size/jlesage/video-duplicate-finder/latest)](https://hub.docker.com/r/jlesage/video-duplicate-finder/tags) [![Build Status](https://github.com/jlesage/docker-video-duplicate-finder/actions/workflows/build-image.yml/badge.svg?branch=master)](https://github.com/jlesage/docker-video-duplicate-finder/actions/workflows/build-image.yml) [![GitHub Release](https://img.shields.io/github/release/jlesage/docker-video-duplicate-finder.svg)](https://github.com/jlesage/docker-video-duplicate-finder/releases/latest) [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/JocelynLeSage)

This is a Docker container for [Video Duplicate Finder](https://github.com/0x90d/videoduplicatefinder).

The GUI of the application is accessed through a modern web browser (no
installation or configuration needed on the client side) or via any VNC client.

---

[![Video Duplicate Finder logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/video-duplicate-finder-icon.png&w=110)](https://github.com/0x90d/videoduplicatefinder)[![Video Duplicate Finder](https://images.placeholders.dev/?width=704&height=110&fontFamily=Georgia,sans-serif&fontWeight=400&fontSize=52&text=Video%20Duplicate%20Finder&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://github.com/0x90d/videoduplicatefinder)

Video Duplicate Finder is a cross-platform software to find duplicated video (and
image) files on hard disk based on similiarity.  That means unlike other duplicate
finders, this one does also finds duplicates which have a different resolution,
frame rate and even watermarked.

---

## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example
and parameters should be adjusted to your need.

Launch the Video Duplicate Finder docker container with the following command:
```shell
docker run -d \
    --name=video-duplicate-finder \
    -p 5800:5800 \
    -v /docker/appdata/video-duplicate-finder:/config:rw \
    -v $HOME:/storage:rw \
    jlesage/video-duplicate-finder
```

Where:
  - `/docker/appdata/video-duplicate-finder`: This is where the application stores its configuration, states, log and any files needing persistency.
  - `$HOME`: This location contains files from your host that need to be accessible to the application.

Browse to `http://your-host-ip:5800` to access the Video Duplicate Finder GUI.
Files from the host appear under the `/storage` folder in the container.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-video-duplicate-finder.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-video-duplicate-finder/issues
