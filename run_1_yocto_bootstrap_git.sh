#!/bin/bash
set -eou pipefail

GIT_OE=https://git.openembedded.org
GIT_YOCTO=https://git.yoctoproject.org
GIT_XILINX=https://github.com/xilinx
GIT_RAUC=https://github.com/rauc


DIRECTORY_OF_THIS_FILE=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
YOCTO_DIRECTORY=$(dirname $(dirname $DIRECTORY_OF_THIS_FILE))

GIT_QUIET="--quiet"

git_checkout () {
    # Example: https://git.openembedded.org
    PARAM_URL=$1
    # Example: openembedded-core
    PARAM_REPO=$2
    # Example: thud
    PARAM_BRANCH=$3
    # Example: sources/openembedded-core
    PARAM_DIRECTORY=$4
    DIRECTORY=$YOCTO_DIRECTORY/$PARAM_DIRECTORY
    GIT_REPO=$PARAM_URL/$PARAM_REPO
    echo "Clone $PARAM_REPO $PARAM_BRANCH into $DIRECTORY"
    mkdir -p $DIRECTORY
    (
        cd $DIRECTORY
        if [ ! -d "$PARAM_REPO/.git" ]; then
            git clone -b $PARAM_BRANCH $GIT_QUIET $GIT_REPO
        fi
    )
}

git_checkout $GIT_YOCTO poky kirkstone layers
git_checkout $GIT_RAUC  meta-rauc kirkstone layers
git_checkout $GIT_RAUC  meta-rauc-community kirkstone layers
