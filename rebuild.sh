#!/usr/bin/env bash
nixos-rebuild -L -v --use-remote-sudo --flake . "$@" --impure
