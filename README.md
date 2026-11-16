# docker-chrony

[![Build Status](https://github.com/dodgeman9/docker-chrony/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/dodgeman9/docker-chrony/actions/workflows/docker-publish.yml)

This Docker image provides a lightweight [Chrony](https://chrony-project.org/) NTP service on Alpine Linux for time synchronization and serving NTP on your network.

## Build

To build the Docker image locally:
```bash
docker build -t docker-chrony .
```

## Run

You can run the container using either `docker run` or `docker compose`.

### Using `docker run`

The `--cap-add SYS_TIME` capability allows Chrony to step and slew the host/container system clock, and `-p 123:123/udp` exposes the NTP server to clients on your network:

```bash
docker run -d \
  --name chrony \
  --cap-add SYS_TIME \
  --restart unless-stopped \
  -p 123:123/udp \
  -e TZ=UTC \
  -e NTP_SERVERS="0.pool.ntp.org 1.pool.ntp.org" \
  -e CHRONY_ALLOW_LIST="all" \
  dodgeman9/chrony:latest
```

> **Note:** If you only want the container to serve NTP to network clients *without* modifying the Docker host's system clock, omit `--cap-add SYS_TIME` and pass `-e NOCLOCK=true`.

### Using `docker compose`

Ensure you have the [`docker-compose.yml`](docker-compose.yml) file in your directory:

```bash
docker compose up -d
```

## Environment Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
| `NTP_SERVERS` | `0.pool.ntp.org 1.pool.ntp.org` | Space-separated list of upstream NTP servers. |
| `CHRONY_ALLOW_LIST` | `all` | Space-separated list of subnets/IPs allowed to query this server (e.g., `192.168.1.0/24 10.0.0.0/8`). |
| `TZ` | `UTC` | Timezone inside the container (e.g., `America/New_York`). |
| `NOCLOCK` | `false` | Set to `true` to pass `-x` to `chronyd` (disables adjusting the system clock). |

