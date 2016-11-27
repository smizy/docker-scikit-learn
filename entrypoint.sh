#!/bin/sh

set -eo pipefail

if [ "$1" == "jupyter" ]; then
    shift
    exec su-exec jupyter jupyter "$@"
fi

exec "$@"