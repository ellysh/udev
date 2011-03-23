#!/bin/bash

# Script for mount flash and cd devices
# Usage: udev-flash-mount.sh [add|remove] DEVICE_NAME

COMMAND=$1
DEV=$2
DEV_DIR=/dev
MEDIA_DIR=/media


sleep 3

check_dev()
{
  # Check the device name command argument

  [ "$DEV" = "" ] && exit 1
}

check_mount()
{
  # Check is mounting was successful

  if [ -n $(df | grep -w $MEDIA_DIR/$DEV) ]
  then
    umount_dev
  fi
}

mount_dev()
{
  # Mount device

  mkdir $MEDIA_DIR/$DEV
  chmod a+rwx $MEDIA_DIR/$DEV
  mount $DEV_DIR/$DEV $MEDIA_DIR/$DEV

  check_mount
}

umount_dev()
{
  # Umount device

  [ ! -d $MEDIA_DIR/$DEV ] && return

  umount $DEV_DIR/$DEV
  rm -rf $MEDIA_DIR/$DEV
}


check_dev

case "$COMMAND" in
  add)
    mount_dev
    ;;
  remove)
    umount_dev
    ;;
esac
