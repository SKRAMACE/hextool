#!/bin/bash

SCRIPT_DIR=/usr/local/bin
PYENV_DIR=/usr/local/pyenv
PYENV_MIROKI=/usr/local/pyenv/miroki

# Install python module
install_wheel(){
    local src=$1

    source $PYENV_MIROKI/bin/activate
    pip3 install $1
    deactivate
}

# Assert root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Make Virtual Environment Directories
if [ ! -d $PYENV_DIR ]; then
    mkdir -p $PYENV_DIR
fi

# Make Virtual Environment
if [ ! -d $PYENV_MIROKI ]; then
    python3 -m venv $PYENV_MIROKI
fi

# Copy scripts
files=($(find . -type f))
for f in ${files[@]}; do
    case $f in
        *.whl)
            install_wheel $f
            ;;
        *)
            ;;
    esac
done
