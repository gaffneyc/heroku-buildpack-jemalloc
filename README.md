# heroku-buildpack-jemalloc

[jemalloc](http://jemalloc.net/) is a general purpose malloc implementation
that works to avoid memory fragmentation in multithreaded applications. This
buildpack makes it easy to install and use jemalloc on Heroku and compatible
platforms.

## Install

```console
heroku buildpacks:add --index 1 https://github.com/gaffneyc/heroku-buildpack-jemalloc.git
git push heroku master
```

## Made possible by Dead Man's Snitch

Continued development and support of the jemalloc buildpack is sponsored by
[Dead Man's Snitch](https://deadmanssnitch.com).

Ever been surprised that a critical recurring job was silently failing to run?
Whether it's backups, cache clearing, sending invoices, or whatever your
application depends on, Dead Man's Snitch makes it easy to
[monitor heroku scheduler](https://deadmanssnitch.com/docs/heroku) tasks or to add
[cron job monitoring](https://deadmanssnitch.com/docs/cron-job-monitoring) to
your other services.

Get started for free today with [Dead Man's Snitch on Heroku](https://elements.heroku.com/addons/deadmanssnitch)

## Usage

### Recommended

Set the JEMALLOC_ENABLED config option to true and jemalloc will be used for
all commands run inside of your dynos.

```console
heroku config:set JEMALLOC_ENABLED=true
```

### Per dyno

To control when jemalloc is configured on a per dyno basis use
`jemalloc.sh <cmd>` and ensure that JEMALLOC_ENABLED is unset.

Example Procfile:
```yaml
web: jemalloc.sh bundle exec puma -C config/puma.rb
```

## Configuration

### JEMALLOC_ENABLED

Set this to true to automatically enable jemalloc.

```console
heroku config:set JEMALLOC_ENABLED=true
```

To disable jemalloc set the option to false. This will cause the application to
restart disabling jemalloc.

```console
heroku config:set JEMALLOC_ENABLED=false
```

### MALLOC_CONF

While jemalloc's default configuration works well in most situations it does
provide a set of options to fine tune performance and memory usage. You can
find a full list of options [in the jemalloc documentation](https://github.com/jemalloc/jemalloc/blob/dev/TUNING.md).


#### Rails

Many Rails applications benefit from a common set of options and the below was
added as the default with dockerfile-rails as of Rails 7.1. While this is a
good default for most Rails apps it prefers performance over minimal memory
usage. For more details on each option and other tested configs with different
trade offs there is more info [in this gist](https://gist.github.com/jjb/9ff0d3f622c8bbe904fe7a82e35152fc#malloc_conf-options).

```
heroku config:set MALLOC_CONF=dirty_decay_ms:1000,narenas:2,background_thread:true
```

### JEMALLOC_VERSION

Set this to select or pin to a specific version of jemalloc. The default is to
use the latest stable version if this is not set. You will receive an error
mentioning tar if the version does not exist.

**Default**: `5.3.1`

**note:** This setting is only used during slug compilation. Changing it will
require a code change to be deployed in order to take affect.

```console
heroku config:set JEMALLOC_VERSION=3.6.0
```

#### Available Versions

| Version                                                          | Released   |
| ---------------------------------------------------------------- | ---------- |
| [3.6.0](https://github.com/jemalloc/jemalloc/releases/tag/3.6.0) | 2015-04-15 |
| [4.0.4](https://github.com/jemalloc/jemalloc/releases/tag/4.0.4) | 2015-10-24 |
| [4.1.1](https://github.com/jemalloc/jemalloc/releases/tag/4.1.1) | 2016-05-03 |
| [4.2.1](https://github.com/jemalloc/jemalloc/releases/tag/4.2.1) | 2016-06-08 |
| [4.3.1](https://github.com/jemalloc/jemalloc/releases/tag/4.3.1) | 2016-11-07 |
| [4.4.0](https://github.com/jemalloc/jemalloc/releases/tag/4.4.0) | 2016-12-04 |
| [4.5.0](https://github.com/jemalloc/jemalloc/releases/tag/4.5.0) | 2017-02-28 |
| [5.0.1](https://github.com/jemalloc/jemalloc/releases/tag/5.0.1) | 2017-07-01 |
| [5.1.0](https://github.com/jemalloc/jemalloc/releases/tag/5.1.0) | 2018-05-08 |
| [5.2.0](https://github.com/jemalloc/jemalloc/releases/tag/5.2.0) | 2019-04-02 |
| [5.2.1](https://github.com/jemalloc/jemalloc/releases/tag/5.2.1) | 2019-08-05 |
| [5.3.0](https://github.com/jemalloc/jemalloc/releases/tag/5.3.0) | 2022-05-06 |
| [5.3.1](https://github.com/jemalloc/jemalloc/releases/tag/5.3.1) | 2026-04-13 |

## Development

Run `make console` to start up a shell in a test build environment that mimic's
Heroku's build phase.
