# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-3.9-r4.ebuild,v 1.1 2001/12/19 03:09:51 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${P}.tar.gz"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" -e "s:-s::" \
	Makefile.orig > Makefile
}

src_compile() {
	emake all || die
}

src_install() {
	into /
	dosbin hdparm
	doman hdparm.8
	dodoc hdparm-*.lsm Changelog
}


