# bashUtils [![Build Status](https://travis-ci.org/athena-oss/bashutils.svg?branch=master)](https://travis-ci.org/athena-oss/bashutils)

bashUtils is a bash library for handling all sorts of contexts, e.g.: arrays, versioning, etc.

The purpose of this project is to have a single library/repo that contains all the bash functions that are reusable in multiple bash-based projects.

## Quick start

Prerequisites
 * You have a `bash` shell.

There are three quick start options available:

* Using [basHog](https://github.com/athena-oss/bashog)
* [Download the latest release](https://github.com/athena-oss/bashutils/releases/latest)
* Clone the repo: `git clone https://github.com/athena-oss/bashutils.git`

## Using it on your project with bashog

Add the file `feed.hog` to the root of your project with the following content :
* When you want a specific version :
```bash
[bashutils]
url=athena-oss/bashutils
version=0.3.0
lib_dir=lib
```
* With the latest master version :
```bash
[bashutils]
url=https://github.com/athena-oss/bashutils.git
lib_dir=lib
```

Run `basHog` in the root of the project

```bash
$ bashog
```

Include/Source the autoloader in your project with the following line :

```bash
source "vendor/autoloader"
```

Use the functions :

```bash
if bashutils.type.is_integer "a" ; then
	...
fi
```

## Contributing

Checkout our guidelines on how to contribute in [CONTRIBUTING.md](CONTRIBUTING.md).

## Versioning

Releases are managed using github's release feature. We use [Semantic Versioning](http://semver.org) for all
the releases. Every change made to the code base will be referred to in the release notes (except for
cleanups and refactorings).

## License

Licensed under the [Apache License Version 2.0 (APLv2)](LICENSE).
