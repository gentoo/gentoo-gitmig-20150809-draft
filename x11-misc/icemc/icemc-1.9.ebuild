# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icemc/icemc-1.9.ebuild,v 1.1 2004/07/27 09:52:06 phosphan Exp $

DESCRIPTION="IceWM menu/toolbar editor"
HOMEPAGE="http://icecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.0.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local:${D}/usr:" -i ${PN}.pro || die "sed failed"
}

src_compile() {
	qmake ${PN}.pro
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "einstall failed"
	rm -rf ${D}/usr/doc
	dohtml icemc/docs/en/*
	dodoc authors ChangeLog readme
}
