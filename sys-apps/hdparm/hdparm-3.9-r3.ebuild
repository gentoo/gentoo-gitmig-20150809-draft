# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-3.9-r3.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${A}"
DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" -e "s:-s::" \
	Makefile.orig > Makefile

}

src_compile() {
	try pmake all
}

src_install() {


	dosbin hdparm
	doman hdparm.8
	dodoc hdparm-*.lsm Changelog

}


