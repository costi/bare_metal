#!/bin/sh

# This script backs up the partition information and the MBR

DEVICE="$1"

if [ -z $DEVICE ]; then
    echo "Usage: $(basename $0) <device>"
    echo "Example: $(basename $0) /dev/sda"
    exit 1
fi

BACKUP_DIR='/backups'

fdisk -l $DEVICE > $BACKUP_DIR/fdisk.txt
sfdisk -dl $DEVICE > $BACKUP_DIR/sfdisk.out
dd if=$DEVICE of=$BACKUP_DIR/mbr bs=512 count=1
