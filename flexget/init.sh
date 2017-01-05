#!/bin/bash

pip install pip flexget -U

if [ ! "$(id -u flexget)" -eq "$PUID" ]; then usermod -o -u "$PUID" flexget ; fi
if [ ! "$(id -g flexget)" -eq "$PGID" ]; then groupmod -o -g "$PGID" flexget ; fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u flexget)
User gid:    $(id -g flexget)
-----------------------------------
"

flexget -c /config/config.yml --loglevel debug daemon start
