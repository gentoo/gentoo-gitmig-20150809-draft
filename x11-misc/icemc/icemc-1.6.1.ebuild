# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icemc/icemc-1.6.1.ebuild,v 1.3 2004/03/21 09:52:51 mholzer Exp $

DESCRIPTION="IceWM menu/toolbar editor"
HOMEPAGE="http://icecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.0.0"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	rm -rf ${D}/usr/doc
	dohtml icemc/docs/en/*
	dodoc authors ChangeLog readme
}
