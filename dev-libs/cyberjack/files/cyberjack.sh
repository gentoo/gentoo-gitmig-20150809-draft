#!/bin/sh
dev_group=cyberjack
dev_mode=0664

# using the cyberJack libusb driver
if [ -n "${DEVICE}" ]; then
  dev="${DEVICE}"
fi

# using the cyberJack kernel module
if [ -n "${DEVNAME}" ]; then
  dev="${DEVNAME}"
fi

# set device group and permissions
/bin/chgrp "${dev_group}" "${dev}"
/bin/chmod "${dev_mode}" "${dev}"
