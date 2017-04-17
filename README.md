# Vault UnOfficial Image Build

Built from the same source as the [Vault Official Image](https://hub.docker.com/_/vault/).

There are several pieces that are used to build this image:

* We start with a CentOS 7 image from openshift  and add CA certificates in order to reach
  the HashiCorp releases server. These are useful to leave in the image so that
  the container can access Atlas features as well.
* Official HashiCorp builds of some base utilities are then included in the
  image by pulling a release of docker-base. This includes dumb-init and gosu.
  See https://github.com/hashicorp/docker-base for more details.
* Finally a specific Vault build is fetched and the rest of the Vault-specific
  configuration happens according to the Dockerfile.

Currently this is set to start in secure server mode, but in memory.

Catalog of errors when building this image:
* Apt calls needed to be replaced with ```yum```
* General issues with GPG probably when downloading hashicorp extras
* adduser and addgroup don't exist in centos7, replaced with groupadd and useradd. flags changed from -S -G to -r -g to create a system user named vault
* docker-entrypoint.sh": executable file not found in $PATH. required a chmod+x for that file once in the container
* Order of yum operations at end of script changed during cleanup
* Error: providing http response to https client. fix -> `export VAULT_ADDR=http://127.0.0.1:8200`
