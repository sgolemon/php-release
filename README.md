# PHP Release Builder

This is an attempt to standardize and automate most of the build process for PHP releases. It is based heavily on dshafik/php-build.

This container is currently based on `ubuntu:xenial`.

It will do the following:

- Clone PHP from the github
- Create the release branch from the correct branch
- Update the version number/date/credits in various files
- Build PHP for nts, debug-nts, zts, and debug-zts and run tests in each version
- Compare the build `-v` version against the intended version
- Create the packages
- Provide instructions for finalizing the release

## Features

- Repeatable, system independent builds
- Configuration file for unattended builds
- Ability to rebuild using release branch

## Running the Container

You need to mount a workspace directory at `/workspace`.
This directory must contain a `config` file (see `config.default` for settings).
The build process will create/overwrite the following folders and files within `/workspace`:

1. `php-src/`: The checkout from php-src. This checkout is performed fresh with every invocation of php-release.
2. `log/{config,make,test}.{debug-,}{nts,zts}`: Results of ./configure, make, and make test across debug/non-debug zts/nts

```sh
docker run --rm -v/home/$USER/workspace:/workspace sgolemon/php-release
```

or

```sh
podman run --rm -v/home/$USER/workspace:/workspace sgolemon/php-release
```

This will pull the image from hub.docker.com and run it.

### Debian Jessie

For the earlier, debian:jessie version of this image, use:

```sh
docker run --rm -v/home/$USER/workspace:/workspace sgolemon/php-release:jessie
```

or

```sh
podman run --rm -v/home/$USER/workspace:/workspace sgolemon/php-release:jessie
```
