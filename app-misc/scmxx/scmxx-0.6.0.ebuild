# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/scmxx/scmxx-0.6.0.ebuild,v 1.8 2003/01/06 01:12:13 agenkin Exp $

DESCRIPTION="Exchange data with Siemens phones."
HOMEPAGE="http://www.hendrik-sattler.de/scmxx/"
SRC_URI="http://ma2geo.mathematik.uni-karlsruhe.de/~hendrik/scmxx/download/${P}.tar.bz2
	http://ma2geo.mathematik.uni-karlsruhe.de/~hendrik/scmxx/download/old/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /usr/lib/scmxx
	doexe contrib/*
	dodoc AUTHORS BUGS CHANGELOG INSTALL README TODO VERSION docs/*.txt
	newdoc docs/README README.doc
}
