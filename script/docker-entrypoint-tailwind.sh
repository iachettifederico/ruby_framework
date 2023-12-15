#!/bin/sh

set -e

yarn check || yarn install

exec "$@"
