#!/bin/bash

set -x

dd if=/dev/urandom of=random-binary bs=1 count=100000

./bin2hex.py -i random-binary -o random-binary.hex

./hex2bin.py -i random-binary.hex -o random-binary.two

hexdump random-binary >hexdump1
hexdump random-binary.two >hexdump2

diff hexdump1 hexdump2

if [ $? != 0 ]; then
    echo "files are not equal. test failed"
    exit 1
else
    echo "files are equal. test passed"
fi

rm -f hexdump1 hexdump2 random-binary.hex random-binary random-binary2



