#!/bin/bash
# Copyright 2004 The Gentoo Foundation, Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap-macos.sh,v 1.2 2004/07/13 00:18:49 pvdabeel Exp $

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

BEAST=`uname -r | grep 7 | echo "Panther" || echo "Tiger"`
RELEASE=`uname -r | grep 7 | echo "10.3" || echo "10.4"`

ebegin "Portage will attempt taming the ${BEAST} it found"

function eaten {
	ewend 1 
	echo -e "Please install the Mac OS X developer tools"
	echo
	exit 1
}

gcc -v 2> /dev/null || eaten
echo 
for package in `cat /usr/portage/profiles/default-macos-${RELEASE}/packages.build`; do
	ebegin " >>> Injecting ${package} " && ewend $?
	emerge inject ${package} > /dev/null 2> /dev/null 
done

echo
echo -e "Portage successfully tamed your ${BEAST}"
