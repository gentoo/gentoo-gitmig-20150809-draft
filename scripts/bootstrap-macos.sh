#!/bin/bash
# Copyright 2004 The Gentoo Foundation, Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap-macos.sh,v 1.5 2004/07/26 20:42:02 pvdabeel Exp $

# Make sure sudo passwd is asked for

sudo true

# Source functions to have colors and nice output

source /usr/lib/portage/bin/functions.sh 

# This is currently a Mac OS only script. But it could easily be reused
# for Operating systems such as Solaris, ... If your interested in doing
# such a port, contact Pieter Van den Abeele at pvdabeel@gentoo.org 

# Note: for complete darwin bootstraps, we'll reuse the regular portage bootstrap.sh

trap 'exit 1' TERM KILL INT QUIT ABRT

echo
echo -e "${GOOD}Gentoo Mac OS ; \e[34;01mhttp://www.gentoo.org/${NORMAL}"
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

sudo ln -sf /usr/portage/profiles/default-macos-${RELEASE} /etc/make.profile

ebegin "Portage will attempt taming your ${NAME}"

function missing_devtools {
	ewend 1 
	echo -e "Please install the ${NAME} developer tools"
	echo
	exit 1
}

gcc -v 2> /dev/null || missing_devtools

echo

# As of 20040726 the part below is no longer needed, we still do it 
# for backwards compatiblity with older installers. 
 
for package in `cat /usr/portage/profiles/default-macos-${RELEASE}/package.provided`; do
	ebegin " >>> Injecting ${package} " && ewend $?
	sudo emerge inject ${package} > /dev/null 2> /dev/null 
done

echo
echo -e "Portage successfully tamed your ${NAME}"
