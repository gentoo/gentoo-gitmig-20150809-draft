#!/bin/sh
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/files/dripgetdvd.sh,v 1.2 2003/04/27 14:27:37 azarah Exp $

# This basically resolves a symlink in /dev to the block device node.  If
# $1 is a absolute path, and that do not exist, we also check /etc/fstab
# if there is an entry, if not we check for an entry of `basename $1`.

if test -z "$1"
then
	exit 1
fi

DVD="$1"

check_device() {
	local DVD="$1"
	local NEWDVD=
	
	while test -L "${DVD}"
	do
		NEWDVD="$(readlink "${DVD}")"
		
		if test -z "$(echo "${NEWDVD}" | grep -e "^/dev")"
		then
			DVD="${DVD%/*}/${NEWDVD}"
		else
			DVD="${NEWDVD}"
		fi
	done

	echo "${DVD}"
}

get_fstab_entry() {
	test -z "$1" && return 1
	
	echo "$(grep "$1" /etc/fstab | awk '$0 !~ /^[[:space:]]*#/ {print $1}')"
}

if ! test -L "${DVD}" && ! test -b "${DVD}"
then
	NEWDVD="$(get_fstab_entry "${DVD}")"

	if test -z "${NEWDVD}"
	then
		NEWDVD="$(get_fstab_entry $(basename "${DVD}"))"
	fi

	if test -z "${NEWDVD}"
	then
		exit 1
	else
		DVD="${NEWDVD}"
	fi
fi

DVD="$(check_device "${DVD}")"

if test -z "${DVD}"
then
	exit 1
fi

if test -b "${DVD}"
then
	echo "$(echo ${DVD} | sed -e 's://:/:g')"
else
	exit 1
fi

exit 0

