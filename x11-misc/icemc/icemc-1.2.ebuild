# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icemc/icemc-1.2.ebuild,v 1.2 2003/04/24 14:09:57 phosphan Exp $

DESCRIPTION="IceWM menu/toolbar editor"
HOMEPAGE="http://tsa.dyndns.org/mirror/xvadim/"
SRC_URI="http://tsa.dyndns.org/mirror/xvadim/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=qt-3.0.0"

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
