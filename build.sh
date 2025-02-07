#!/bin/bash

# Here is the command that can be used to debug or develop with the
# local resources.
#
# docker run --rm -ti -v `pwd`:/data -v `pwd`/build-tools/tools:/tools -v `pwd`/data/boilerplate/dashif:/usr/local/lib/python3.12/dist-packages/bikeshed/spec-data/boilerplate/dashif dashif-specs:latest
#

# Run the docker container and pass all the arguments
IMG=dashif/specs-builder:latest

# Allow to overwrite additional options from the outside.
# We use tty and interactive by default since this makes it easier
# to deal with watch mode and Ctrl-C etc but we can not use this
# for instance in CI mode
if [ -z ${OPTS+x} ]; then
  OPTS=-ti
fi

TARGETS="${@}"
if [ -z "${TARGETS}" ]; then
  TARGETS="spec"
fi
# Add parameters
TARGETS="${TARGETS} SRC=Guidelines-TimingModel.bs.md NAME=Timing-Model"

echo "Run with targets: '${TARGETS}'"
docker run --rm ${OPTS} -v `pwd`:/data -p 8000:8000 \
  ${IMG} ${TARGETS}
