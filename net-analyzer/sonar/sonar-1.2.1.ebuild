# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sonar/sonar-1.2.1.ebuild,v 1.2 2004/03/21 17:27:38 weeve Exp $

inherit gcc eutils

DESCRIPTION="network reconnaissance utility"
HOMEPAGE="http://autosec.sourceforge.net/"
SRC_URI="mirror://sourceforge/autosec/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/glibc
	>=dev-libs/popt-1.7-r1
	>=app-doc/doxygen-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-libtool.patch
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README AUTHORS CONTRIB NEWS
	dohtml doc/html/*
	rm -rf ${D}/usr/share/sonar
}
