#!/bin/bash
# Copyright 2004 The Gentoo Foundation, Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap-macos.sh,v 1.9 2004/11/21 17:32:37 kito Exp $

# Make sure sudo passwd is asked for

sudo true

# Source functions to have colors and nice output

trap 'exit 1' TERM KILL INT QUIT ABRT

echo
echo -e "Gentoo for Mac OS X; http://www.gentoo.org/"
echo -e "Copyright 2004 The Gentoo Foundation ; Distributed under the GPL v2"
echo

NAME="Mac OS X"
RELEASE="10"

case "`uname -r`" in
        6*)
		# We don't really support this
		NAME="Jaguar"
		# We reuse the Panther profile
		RELEASE="10.3"
		;;
		7*)
		NAME="Panther"
		RELEASE="10.3"
		;;
        8*)
        NAME="Tiger"
		RELEASE="10.4"
		;;
esac

sudo ln -sf /usr/portage/profiles/default-darwin/macos/${RELEASE} /etc/make.profile

# ebegin "Portage will attempt taming your ${NAME}"

function missing_devtools {
	ewend 1 
	echo -e "Please install the ${NAME} developer tools (>1.1)"
	echo
	exit 1
}

gcc -v 2> /dev/null || missing_devtools

echo
echo -e "Portage successfully tamed your ${NAME}"
