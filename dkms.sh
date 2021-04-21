#!/bin/sh

set -e

if [ "$1" = "-u" ]; then
    dkms remove hid-asus-flow-x13/1.0 --all
else
    dkms install drivers/hid
fi

# dracut --force