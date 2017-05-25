#!/bin/bash
set -e

PHP_SRC=${1:?"Missing argument pointing to workspace/php-src"}
RELEASE_VERSION=${2:?"Missing Release Version"}
TAG_COMMIT=${3:?"Missing tag commit"}
GPG_KEY=${4:?"Missing GPG fingerprint"}
GPG_USER=${5:?"Missing GPG user"}

git tag -u "${GPG_KEY}" "php-${RELEASE_VERSION}" -m "Tag for php ${RELEASE_VERSION}" "$TAG_COMMIT"
for COMP in gz bz2 xz; do
	gpg -u "${GPG_USER}" --armor --detach-sign "${PHP_SRC}/php-${RELEASE_VERSION}.tar.$COMP"
done

