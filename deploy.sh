#!/bin/sh
nixos-rebuild switch --target-host root@5.161.71.187 --flake .#hetzner-cloud-common
