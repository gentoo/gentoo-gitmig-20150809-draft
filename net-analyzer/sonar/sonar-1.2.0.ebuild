# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sonar/sonar-1.2.0.ebuild,v 1.2 2003/10/02 18:09:23 vapier Exp $

inherit gcc eutils

DESCRIPTION="network reconnaissance utility"
HOMEPAGE="http://autosec.sourceforge.net/"
SRC_URI="mirror://sourceforge/autosec/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-doc.patch
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README AUTHORS CONTRIB NEWS
	dohtml doc/html/*
	rm -rf ${D}/usr/share/sonar
}
