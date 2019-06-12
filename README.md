# jemalloc Buildpack

[jemalloc](http://jemalloc.net/) is a general purpose malloc implementation
that works to avoid memory fragmentation in multithreaded applications. This
buildpack makes it easy to install and use jemalloc on Scalingo and compatible
platforms.

## Install

```console
scalingo env-set BUILDPACK_URL=https://github.com/Scalingo/multi-buildpack.git
```

And in a `.buildpacks` file (example with ruby):

```
https://github.com/Scalingo/jemalloc-buildpack.git
https://github.com/Scalingo/ruby-buildpack.git
```

## Usage

### Recommended

Set the JEMALLOC_ENABLED config option to true and jemalloc will be used for
all commands run inside of your containers.

```console
scalingo env-set JEMALLOC_ENABLED=true
```

### Per container

To control when jemalloc is configured on a per container basis use
`jemalloc.sh <cmd>` and ensure that JEMALLOC_ENABLED is unset.

Example Procfile:
```yaml
web: jemalloc.sh bundle exec puma -C config/puma.rb
```

## Configuration

### JEMALLOC_ENABLED

Set this to true to automatically enable jemalloc.

```console
scalingo env-set JEMALLOC_ENABLED=true
```

To disable jemalloc set the option to false. This will cause the application to
restart disabling jemalloc.

```console
scalingo env-set JEMALLOC_ENABLED=false
```

### JEMALLOC_VERSION

Set this to select or pin to a specific version of jemalloc. The default is to
use the latest stable version if this is not set. You will receive an error
mentioning tar if the version does not exist.

**Default**: `5.2.0`

**note:** This setting is only used during slug compilation. Changing it will
require a code change to be deployed in order to take affect.

```console
scalingo env-set JEMALLOC_VERSION=3.6.0
```

#### Available Versions

| Version                                                          |
| ---------------------------------------------------------------- |
| [3.6.0](https://github.com/jemalloc/jemalloc/releases/tag/3.6.0) |
| [4.0.4](https://github.com/jemalloc/jemalloc/releases/tag/4.0.4) |
| [4.1.1](https://github.com/jemalloc/jemalloc/releases/tag/4.1.1) |
| [4.2.1](https://github.com/jemalloc/jemalloc/releases/tag/4.2.1) |
| [4.3.1](https://github.com/jemalloc/jemalloc/releases/tag/4.3.1) |
| [4.4.0](https://github.com/jemalloc/jemalloc/releases/tag/4.4.0) |
| [4.5.0](https://github.com/jemalloc/jemalloc/releases/tag/4.5.0) |
| [5.0.1](https://github.com/jemalloc/jemalloc/releases/tag/5.0.1) |
| [5.1.0](https://github.com/jemalloc/jemalloc/releases/tag/5.1.0) |
| [5.2.0](https://github.com/jemalloc/jemalloc/releases/tag/5.2.0) |

The complete and most up to date list of supported versions and stacks is
available on the [releases page.](https://github.com/Scalingo/jemalloc-buildpack/releases)

## Thanks

Continued development of the jemalloc buildpack is sponsored by [Dead Man's Snitch](https://deadmanssnitch.com).
Ever been surprised that a critical scheduled task was silently failing to
run? Whether it's backups, cache clearing, or sending invoices, Dead Man's Snitch makes it easy to
[monitor heroku scheduler](https://deadmanssnitch.com/docs/heroku) tasks or to add
[cron job monitoring](https://deadmanssnitch.com/docs/cron-job-monitoring)
to your other services.

Get started for free today with [Dead Man's Snitch on Heroku](http://github.com/deadmanssnitch/heroku-buildpack-dms)

## Building

This uses Docker to build against Scalingo
[stack-image](https://doc.scalingo.com/platform/internals/base-docker-image#top-of-page)-like images.

```console
make VERSION=5.2.0
```

Artifacts will be dropped in `dist/` based on Scalingo stack and jemalloc version.

### Deploying New Versions

- `make VERSION=X.Y.Z`
- `open dist`
- Go to [releases](https://github.com/Scalingo/jemalloc-buildpack/releases)
- Edit the release corresponding to each scalingo Stack
- Drag and drop the new build to attach

### Creating a New Stack
- Go to [releases](https://github.com/Scalingo/jemalloc-buildpack/releases)
- Click "Draft a new release"
- Tag is the name of the Stack (e.g. `scalingo-18`)
- Target is `release-master`
- Title is `Builds for the [stack] stack`
