#!/usr/bin/env bash
nixos-rebuild -L -v --sudo --flake . "$@" --impure
