#!/bin/bash

. sw-packaging.sh

if [ -d ./dist ]; then
    rm -rf ./dist
fi

# This creates DIST directory
python3 -m build -w

DIST=$(pwd)/dist
if [ ! -d $DIST ]; then
    echo "ERROR: python build failure"
    exit 1
fi

TAR_FNAME=$NAME-$VERSION
TARDIR=$DIST/$TAR_FNAME
mkdir -p $TARDIR

cp $DIST/*.whl $TARDIR

if [ -e diff.diff ]; then
    cp diff.diff $TARDIR
fi

if [ -e $PACKAGE_INFO ]; then
    echo "cp $PACKAGE_INFO $TARDIR"
    cp $PACKAGE_INFO $TARDIR
fi

cp install.sh $TARDIR

TARFILE=$DIST/$TAR_FNAME.tar.gz
tar -C $DIST -cf $TARFILE $TAR_FNAME

TARFILE_NOVER=$DIST/$NAME.tar.gz
cp $TARFILE $TARFILE_NOVER

EGG=$NAME.egg-info
if [ -d $EGG ]; then
    rm -r $EGG
fi
