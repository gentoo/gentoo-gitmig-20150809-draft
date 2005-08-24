# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hyperestraier/hyperestraier-0.5.1.ebuild,v 1.2 2005/08/24 11:02:25 hattya Exp $

IUSE="debug"

DESCRIPTION="a full-text search system for communities"
HOMEPAGE="http://hyperestraier.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~ppc x86"
SLOT="0"

DEPEND=">=dev-db/qdbm-1.8.29
	sys-libs/zlib"

src_compile() {

	econf \
		`use_enable debug` \
		|| die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc COPYING README* ChangeLog THANKS
	dohtml -r doc/*

	rm -f ${D}/usr/share/${PN}/{COPYING,ChangeLog,THANKS}
	rm -rf ${D}/usr/share/${PN}/doc

}
