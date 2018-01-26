#!/bin/bash
ROOT=$TRAVIS_BUILD_DIR/..

# Required argument $1 is one of:
#   formatter, interning, lock, nullness, regex, signature, nothing


# Fail the whole script if any command fails
set -e

## Short version, intended to be used when triggering downstream Travis jobs.
echo "Should next trigger downstream jobs."
true

## Build Checker Framework
(cd $ROOT && git clone --depth 1 -b index-casestudies https://github.com/typetools/checker-framework.git)
# This also builds annotation-tools and jsr308-langtools
(cd $ROOT/checker-framework/ && ./.travis-build-without-test.sh downloadjdk)
export CHECKERFRAMEWORK=$ROOT/checker-framework

## Obtain guava
(cd $ROOT && git clone --depth 1 -b index https://github.com/kelloggm/jfreechart.git)

if [[ "$1" == "index" ]]; then
  (cd $ROOT/jfreechart/ant && ant check-index)
  true
else
  echo "Bad argument '$1' to travis-build.sh"
  false
fi
