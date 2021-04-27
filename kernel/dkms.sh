#!/bin/sh

set -e

if [ "$1" = "-u" ]; then
    sudo dkms remove asus-flow-x13/1.0 --all
else
    rm -rf sound
    cp -r upstream/sound sound
    git apply patches/sound.patch
    
    rm -rf drivers
    cp -r upstream/drivers drivers
    git apply patches/keyboard.patch

    sudo dkms install .

    rm -r sound
    rm -r drivers
fi

# dracut --force