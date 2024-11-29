# Docker Openvpn
Openvpn docker image

## Features

This docker image runs an Openvpn service on an[ Alpine](https://www.alpinelinux.org/) linux base image.

1. Stateless
2. Accepts openvpn `server.conf` as env var
3. NAT + default route

## Expose

* `1194/udp`
* `1194/tcp`

## Volumes
No volumes required

## How to use this image
```bash
docker compose -p openvpn up -d --force-recreate
```

or with Makefile:
```bash
make up
```

## Environment variables

* `CONFIG` - (multi-line): Openvpn config: keys / CA / params / etc

## TODO

Use `NET` param in config
