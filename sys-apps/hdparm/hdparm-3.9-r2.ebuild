# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-3.9-r2.ebuild,v 1.2 2000/11/30 23:14:33 achim Exp $

P=hdparm-3.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try pmake all
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" \
	-e "s:-s::" \
	Makefile.orig > Makefile
}

src_install() {                               
	into /usr
	dosbin hdparm
	doman hdparm.8
	dodoc hdparm-*.lsm Changelog
}


