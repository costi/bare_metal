#!/bin/sh

# This script restores up the partition information and the MBR
# THIS SCRIPT WILL WIPE OUT YOUR MBR AND PARTITION INFORMATION
# and it will rewrite them with the info in SFDISK_OUT and MBR

DEVICE="$1"
SFDISK_OUT="$2"
MBR="$3"

if [ -z $DEVICE ] || [ -z $SFDISK_OUT ] || [ -z $MBR ]; then
    echo "Usage: $(basename $0) <device> <FILENAME:sfdisk_dump> <FILENAME:mbr_dump>"
    echo "Example: $(basename $0) /dev/sda sfdisk.out mbr"
    exit 1
fi

if [ -z "`file $SFDISK_OUT | grep text`" ]; then
    echo "Error: sfdisk $SFDISK_OUT doesn't seem to be a text file."
    exit 1
fi

if [ -z "`file $MBR | grep 'GRand Unified Bootloader'`" ]; then
    echo "Error: mbr $MBR doesn't seem to be a mbr dump."
    exit 1
fi

sfdisk $DEVICE < $SFDISK_OUT 
dd if=$MBR of=$DEVICE bs=512 count=1
