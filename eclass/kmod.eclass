# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kmod.eclass,v 1.9 2003/03/01 19:11:04 lostlogic Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# The base eclass defines some default functions and variables. Nearly everything
# else inherits from here.

ECLASS=kmod
INHERITED="$INHERITED $ECLASS"
S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

SRC_URI="mirrof://gentoo/${P}.patch.bz2"

kmod_src_unpack() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && base_src_unpack all

	debug-print-section patch
	cd /usr/src/linux-${KV}
	patch -p1 < ${DISTDIR}/${P}.patch
	  
}

EXPORT_FUNCTIONS src_unpack
