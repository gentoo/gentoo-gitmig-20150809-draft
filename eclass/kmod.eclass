# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kmod.eclass,v 1.3 2002/08/27 23:56:38 mjc Exp $
# The base eclass defines some default functions and variables. Nearly everything
# else inherits from here.
ECLASS=kmod
INHERITED="$INHERITED $ECLASS"
S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

kmod_src_unpack() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && base_src_unpack all

	cd ${WORKDIR}

	debug-print-section patch
	cd /usr/src/linux-${KV}
	patch -p1 < ${FILESDIR}/${P}.patch
	  
}

EXPORT_FUNCTIONS src_unpack
