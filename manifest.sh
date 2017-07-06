#!/bin/bash
set -e

BASENAME=${1:?"Mising basename of tarfile"}

for COMP in gz bz2 xz; do
	echo "$BASENAME.$COMP"
	echo -n "SHA256 hash: "
	sha256sum "$BASENAME.$COMP" | cut -d ' ' -f 1
	if [ -f "$BASENAME.$COMP.asc" ]; then
		echo "PGP signature:"
		cat "$BASENAME.$COMP.asc"
	fi
	echo ""
done
