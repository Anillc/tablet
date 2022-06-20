#!/usr/bin/env bash
nixos-rebuild --print-build-logs switch --use-remote-sudo --flake .
