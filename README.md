<p align="right">
  <a href="https://github.com/sponsors/vic"><img src="https://img.shields.io/badge/sponsor-vic-white?logo=githubsponsors&logoColor=white&labelColor=%23FF0000" alt="Sponsor Vic"/>
  </a>
  <a href="https://vic.github.io/dendrix/Dendritic-Ecosystem.html#vics-dendritic-libraries"> <img src="https://img.shields.io/badge/Dendritic-Nix-informational?logo=nixos&logoColor=white" alt="Dendritic Nix"/> </a>
  <a href="LICENSE"> <img src="https://img.shields.io/github/license/vic/dendritic-unflake" alt="License"/> </a>
  <a href="https://github.com/vic/dendritic-unflake/actions">
  <img src="https://github.com/vic/dendritic-unflake/actions/workflows/test.yaml/badge.svg" alt="CI Status"/> </a>
</p>

This repo contains several non-flakes examples (one per branch):

- [unflake](https://github.com/vic/dendritic-unflake/tree/main) **current**
- [npins](https://github.com/vic/dendritic-unflake/tree/npins)


# Dendritic unflake

This repository serves as an example Dendritic Nix implementation **without** flakes nor flake-parts.
([discourse post](https://discourse.nixos.org/t/dendritic-unflake-example-dendritic-setup-without-flakes-nor-flake-parts/73069/5) and [context](https://github.com/mightyiam/dendritic/pull/15))


Entry point is [default.nix](default.nix), [modules/example.nix](modules/example.nix) defines a nixosConfiguration.


This example uses [unflake](https://discourse.nixos.org/t/unflake-flake-dependencies-for-non-flake-projects-and-a-way-to-stop-writing-follows/72611) to fetch dependencies and provide flake-like inputs.


## Usage

Regenerate [unflake.nix](unflake.nix) whenever [inputs.nix](inputs.nix) change:

```console
nix-shell https://ln-s.sh/unflake -A unflake-shell --run unflake
```

Build `my-laptop` nixos config:

```console
nixos-rebuild build --file . --attr nixosConfigurations.my-laptop
```

alternatively:

```console
nix-build --attr nixosConfigurations.my-laptop.config.system.build.toplevel
```
