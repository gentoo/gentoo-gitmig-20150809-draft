#!/usr/bin/env sh
# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/files/gnustep-3.sh,v 1.1 2010/03/09 18:52:56 grobian Exp $

# Test for an interactive shell
case $- in
	*i*)
	;;
	*)
		return
	;;
esac
	
GNUSTEP_SYSTEM_TOOLS="@GENTOO_PORTAGE_EPREFIX@"/usr/GNUstep/System/Tools

if [ -x ${GNUSTEP_SYSTEM_TOOLS}/make_services ]; then
    ${GNUSTEP_SYSTEM_TOOLS}/make_services
fi

if [ -x ${GNUSTEP_SYSTEM_TOOLS}/gdnc ]; then
    ${GNUSTEP_SYSTEM_TOOLS}/gdnc
fi
