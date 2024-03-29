[![Release Bmeme NG-CLI container images](https://github.com/bmeme/docker-ng-cli/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/bmeme/docker-ng-cli/actions/workflows/release.yml)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

NG-CLI packaged by Bmeme
===========

This image provides a node container with NG CLI installed and support to build static Angular sites with [Scully](https://scully.io/).

## What is contained in the images
- Angular CLI, of course
- Chromium

## Tagging policy
This repository contains a single "dynamic" Dockerfile that receives as arguments the major version of Node and the major version of the NG CLI. Consequently, the resulting image tag consists of a first number identifying the CLI version and a second number identifying the Node version. During the build process, the complete version of the NG CLI is extracted, allowing images to be tagged with the full NG CLI version (major-minor-patch). The image build process is automated on every merge to the main branch and scheduled to run at least once a week, ensuring a continuous refresh of images for the same major releases.

## Supported NG-CLI and Node versions
- NG-CLI `17.x.x` with Node `18.x.x` and `20.x.x`
- NG-CLI `16.x.x` with Node `18.x.x` and `16.x.x`
- NG-CLI `15.x.x` with Node `18.x.x` and `16.x.x`

Get a look here: https://hub.docker.com/r/bmeme/ng-cli/tags

## How to use this image

### Manually
Creating your Angular environment an starting your Angular application is really simple:

```shell
docker run --rm -v "$PWD":/app bmeme/ng-cli ng new myangularapp

cd myangularapp
docker run --rm -v "$PWD":/app bmeme/ng-cli ng build

docker run --rm -p 4200:4200 -v "$PWD":/app bmeme/ng-cli ng serve --host 0.0.0.0
```

### Using a Dockerfile
```dockerfile
FROM bmeme/ng-cli:latest
COPY src/ /app

CMD ['ng', 'serve', '--host', '0.0.0.0']
```
Where `src/` is the directory containing your Angular app.

Then, run the commands to build and run the Docker image:
```shell
$ docker build -t myangularcontainer:latest .
$ docker run -d --name myangularcontainer -p 4200:4200 myangularcontainer:latest
```
## Using `docker compose`

```yaml
services:
  php:
    image: bmeme/ng-cli:latest
    ports:
      - 4200:4200
    volumes:
      - .:/app
    command: ng serve --host 0.0.0.0
```

## Credits
This project is a contribution of [Bmeme :: The Digital Factory](http://www.bmeme.com).
This library is actually maintained by [Daniele Piaggesi](https://github.com/g0blin79) and
[Roberto Mariani](https://github.com/jean-louis).
Any other contribution will be really appreciated.