#!/bin/bash

#VERSION 1.0.0

USER="janotelo-vm"
MOUNT_POINT="/home/$USER/yocto_builds"
TARGET_SIZE_GB=350

DEVICE_ID=$(lsblk -ndo NAME,TYPE,SIZE | grep $TARGET_SIZE_GB | awk '{print $1}')

if [ -z "$DEVICE_ID" ]; then
    echo "ERROR: No ~350 GB disk found."
    exit 1
fi

echo "Found disk: /dev/$DEVICE_ID"

# Check if already mounted
if mountpoint -q "$MOUNT_POINT"; then
    echo "$MOUNT_POINT is already mounted."
    exit 0
fi

# Mount
mount "/dev/$DEVICE_ID" "$MOUNT_POINT"

echo "Successfully mounted $DEVICE_ID to $MOUNT_POINT"
