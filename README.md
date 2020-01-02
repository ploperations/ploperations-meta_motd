# meta_motd

![](https://img.shields.io/puppetforge/pdk-version/ploperations/meta_motd.svg?style=popout)
![](https://img.shields.io/puppetforge/v/ploperations/meta_motd.svg?style=popout)
![](https://img.shields.io/puppetforge/dt/ploperations/meta_motd.svg?style=popout)
[![Build Status](https://travis-ci.org/ploperations/ploperations-meta_motd.svg?branch=master)](https://travis-ci.com/ploperations/ploperations-meta_motd)

meta_motd is used internally at Puppet create a message of the day that includes metadata about the node.

- [Description](#description)
  - [Examples](#examples)
- [Setup](#setup)
  - [Beginning with meta_motd](#beginning-with-meta_motd)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)
- [Limitations](#limitations)
- [Development](#development)

## Description

The message of the day is the first thing a user sees when logging into a system. Providing contextual information about the system allows users to quickly get an overview of what the system does. This methodology also allows for providing supplemental information to the user at login.

### Examples

Here are a couple of examples of what this module can produce. Note, some of the data shown here is added by ploperations/profile_metadata.

```plain
# add stuff here....
```

## Setup

This module will fully manage `/etc/motd`.

### Beginning with meta_motd

This module will work without additional setup on your part. Optionally, you can provide a different epp template and parameter hash.

## Usage

```puppet
include meta_motd
```

## Reference

This module is documented via `pdk bundle exec puppet strings generate --format markdown`. Please see [REFERENCE.md](REFERENCE.md) for more info.

## Changelog

[CHANGELOG.md](CHANGELOG.md) is generated prior to each release via `pdk bundle exec rake changelog`. This process relies on labels that are applied to each pull request.

## Limitations

This module does not currently do anything on Windows nodes.

## Development

PR's are welcome!
