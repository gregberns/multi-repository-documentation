# Multi-Repository Documentation

## Purpose

Show how Sphinx can be used to aggregate several repository's documentation together into a single static site.

## Adding more repositories

Example:

* `cd repos`
* `git submodule add https://github.com/gregberns/identity-provider-demo`
* Add `repos/identity-provider-demo/README.md` to the `index.rst` file

## Running

### For Production

```bash
git submodule init
git submodule update --recursive --remote --force

docker-compose build
docker-compose up
```

or

```bash
docker build -t sphinx-autobuild .

# to debug
docker run -it --rm sphinx-autobuild sh
# to run
docker run -it --rm -p "8000:80" sphinx-autobuild
```

### Local

To run in local/debug mode

```bash
docker build -t sphinx-autobuild -f Dockerfile.debug .
docker run -it -p 8000:8000 --rm -v "$(pwd)":/home/python/docs sphinx-autobuild
```

## Atttribution

https://github.com/keimlink/docker-sphinx-doc
http://fmarco76.github.io/git%20and%20related%20services/readthedocs/