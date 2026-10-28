#!/usr/bin/env sh

# impure to allow runtime nixGL system detection
NIXPKGS_ALLOW_UNFREE=1 nix develop --extra-experimental-features nix-command --extra-experimental-features flakes --impure
