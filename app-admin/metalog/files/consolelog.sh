#!/bin/sh
#
# consolelog.sh
# For metalog -- log to a console
#
# from LFS
#

echo "$1 [$2] $3" >/dev/vc/10

#
# of course, you can log to multiple devices
#
#echo "$1 [$2] $3" >/dev/console
