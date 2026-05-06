# docker-chrony

[![Build Status](https://github.com/dodgeman9/docker-chrony/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/dodgeman9/docker-chrony/actions/workflows/docker-publish.yml)

This Docker image provides a Chrony service for time synchronization.

## Build

To build the Docker image locally:
```bash
docker build -t docker-chrony .
```

## Run

You can run the container in two ways:

### Using `docker run`

This command starts the container and ensures it restarts automatically if it stops. The `--cap-add SYS_TIME` capability is necessary for the container to set the system clock.

```bash
docker run -d --name chrony --cap-add SYS_TIME --restart always docker-chrony
```

### Using `docker compose`

Ensure you have a `docker-compose.yaml` file (or `compose.yaml`) in your directory. This setup defines the `chrony` service.

```bash
docker compose up -d
