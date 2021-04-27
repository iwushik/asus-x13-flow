#!/bin/sh

set -e

if [ "$1" = "-u" ]; then
    dkms remove hid-asus-flow-x13/1.0 --all
else
    cp -r upstream/sound sound
    git apply patches/sound.patch
    
    cp -r upstream/drivers drivers
    git apply patches/keyboard.patch

    dkms install .

    rm -r sound
    rm -r drivers
fi

# dracut --force