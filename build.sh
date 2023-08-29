#!/bin/bash

. sw-packaging.sh

if [ -d ./dist ]; then
    rm -rf ./dist
fi

# This creates DIST directory
python3 -m build -w

DIST=./dist
if [ ! -d $DIST ]; then
    echo "ERROR: python build failure"
    exit 1
fi

TARDIR=./dist/$NAME-$VERSION
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

TARFILE=$DIST/$NAME-$VERSION.tar.gz
tar -cf $TARFILE $TARDIR 

EGG=$NAME.egg-info
if [ -d $EGG ]; then
    rm -r $EGG
fi
