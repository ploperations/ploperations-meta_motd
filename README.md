# meta_motd

![](https://img.shields.io/puppetforge/pdk-version/ploperations/meta_motd.svg?style=popout)
![](https://img.shields.io/puppetforge/v/ploperations/meta_motd.svg?style=popout)
![](https://img.shields.io/puppetforge/dt/ploperations/meta_motd.svg?style=popout)
[![Build Status](https://travis-ci.org/ploperations/ploperations-meta_motd.svg?branch=master)](https://travis-ci.com/ploperations/ploperations-meta_motd)

- [Description](#description)
  - [Examples](#examples)
- [Setup](#setup)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)
- [Limitations](#limitations)
- [Development](#development)

## Description

The message of the day, or MOTD, is the first thing a user sees when logging into a system. Providing contextual information about the system allows users to quickly get an overview of what the system does. This module is used internally at Puppet and is actively maintained.

### Examples

Below are a some examples of what this module can produce.

> Note that the `Consul Agent (profile::consul)` line below each MOTD was added by [ploperations/profile_metadata](https://forge.puppet.com/ploperations/profile_metadata)

**short-puppet.epp**:

```plain
canary-basic-debian8-dev-1.example.net - 10.0.0.20 - opdx
 _____                 _
|  _  |_ _ ___ ___ ___| |_
|   __| | | . | . | -_|  _|  Puppet 6.10.1 in production
|__|  |___|  _|  _|___|_|    role::canary::basic
          |_| |_|

Canary node
  role::canary::basic owned by team infracore

Consul Agent (profile::consul)
```

**tall-puppet.epp**:

```plain
 ____  __ __  ____  ____   ___ ______
|    \|  |  ||    \|    \ /  _]      |  Env: production
|  o  )  |  ||  o  )  o  )  [_|      |  OS: Debian 8 aka jessie
|   _/|  |  ||   _/|   _/    _]_|  |_|  Location: opdx in vmware
|  |  |  :  ||  |  |  | |   [_  |  |    Puppet: 6.10.1
|  |  |     ||  |  |  | |     | |  |
|__|   \__,_||__|  |__| |_____| |__|
FQDN: canary-basic-debian8-dev-1.example.net

Canary node
  role::canary::basic owned by team infracore

Consul Agent (profile::consul)
```

**colossal-puppet-dag.epp**:

```plain
canary-basic-debian8-dev-1.example.net - 10.0.0.20 - opdx

8888888b.                                      888    @@@@@@@@@@@@@@@
888   Y88b                                     888    @,,,,,,@@@@@@@@
888    888                                     888    @,,@@,,@@@@@@@@
888   d88P 888  888 88888b.  88888b.   .d88b.  888888 @,,,,,,,@@@@@@@
8888888P"  888  888 888 "88b 888 "88b d8P  Y8b 888    @@@@@@@@,,,,,,@ Puppet 6.10.1 in production
888        888  888 888  888 888  888 88888888 888    @@@@@@@@,,,,,,@ role::canary::basic
888        Y88b 888 888 d88P 888 d88P Y8b.     Y88b.  @@@@@@@@,,,,,,@
888         "Y88888 88888P"  88888P"   "Y8888   "Y888 @,,,,,,,@@@@@@@
                    888      888                      @,,@@,,@@@@@@@@
                    888      888                      @,,,,,,@@@@@@@@
                    888      888                      @@@@@@@@@@@@@@@


Canary node
  role::canary::basic owned by team infracore

Consul Agent (profile::consul)
```

## Setup

This module will fully manage `/etc/motd` while also allowing other module (or profiles) to add information to it. This module will work without additional setup on your part. See [Reference](https://forge.puppet.com/ploperations/meta_motd/reference) on the Puppet Forge or [REFERENCE.md](REFERENCE.md) on GitHub for additional details about setup options.

## Usage

```puppet
include meta_motd
```

## Reference

This module is documented via `pdk bundle exec puppet strings generate --format markdown`. Please see [Reference](https://forge.puppet.com/ploperations/github/reference) on the Puppet Forge or [REFERENCE.md](REFERENCE.md) on GitHub for more info.

## Changelog

[CHANGELOG.md](CHANGELOG.md) is generated prior to each release via `pdk bundle exec rake changelog`. This process relies on labels that are applied to each pull request.

## Limitations

This module does not currently do anything on Windows nodes.

## Development

PR's, including ones with additional templates, are welcome!
