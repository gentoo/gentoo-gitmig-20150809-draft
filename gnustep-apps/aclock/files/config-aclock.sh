#!/bin/bash
#
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/aclock/files/config-aclock.sh,v 1.2 2004/09/28 00:50:15 swegener Exp $

echo "AClock can draw with a smooth second hand or normal.  Please choose one."
read -p "'smooth' or 'normal': " style

if [ -n $style ]; then
	case $style in
		smooth)
			echo "defaults write AClock SmoothSeconds YES"
			echo "defaults write AClock RefreshRate 0.1"
			defaults write AClock SmoothSeconds YES
			defaults write AClock RefreshRate 0.1
			;;
		normal)
			echo "defaults write AClock SmoothSeconds NO"
			echo "defaults write AClock RefreshRate 1.0"
			defaults write AClock SmoothSeconds NO
			defaults write AClock RefreshRate 1.0
			;;
		*)
			echo "Please enter 'smooth' or 'normal'."
			;;
	esac
else
	echo "Please enter 'smooth' or 'normal'."
fi

