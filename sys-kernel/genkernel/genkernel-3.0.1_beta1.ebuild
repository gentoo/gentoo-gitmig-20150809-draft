# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.0.1_beta1.ebuild,v 1.2 2004/02/06 18:18:27 iggy Exp $

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~brad_mssw/genkernel/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
}

src_install() {
	mkdir -p ${D}/etc
	cp ${S}/genkernel.conf ${D}/etc
	mkdir -p ${D}/usr/bin
	cp ${S}/genkernel ${D}/usr/bin
	mkdir -p ${D}/usr/share/genkernel
	cp -Rpv ${S}/* ${D}/usr/share/genkernel
	rm -f ${D}/usr/share/genkernel/genkernel.conf ${D}/usr/share/genkernel/genkernel
}
