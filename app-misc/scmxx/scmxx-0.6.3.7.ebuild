# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/scmxx/scmxx-0.6.3.7.ebuild,v 1.1 2003/05/26 16:57:02 hanno Exp $

DESCRIPTION="Exchange data with Siemens phones."
HOMEPAGE="http://www.hendrik-sattler.de/scmxx/"
SRC_URI="http://ma2geo.mathematik.uni-karlsruhe.de/~hendrik/scmxx/download/${P}.tar.bz2
	http://ma2geo.mathematik.uni-karlsruhe.de/~hendrik/scmxx/download/old/${P}.tar.bz2"
DEPEND="virtual/glibc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /usr/lib/scmxx
	doexe contrib/*
	dodoc AUTHORS BUGS CHANGELOG INSTALL README TODO VERSION docs/*.txt
	newdoc docs/README README.doc
}
