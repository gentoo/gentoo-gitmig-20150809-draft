# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-2.0.ebuild,v 1.3 2003/04/24 14:06:18 phosphan Exp $

DESCRIPTION="IceWM Control Center (only main program, see icewm-tools for the rest)"
SRC_URI="http://tsa.dyndns.org/mirror/xvadim/${P}.tar.bz2"
HOMEPAGE="http://tsa.dyndns.org/mirror/xvadim/"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=qt-3.0.0"

SLOT="0"

inherit eutils

src_unpack () {
	unpack ${A}
    cd ${S}
	epatch ${FILESDIR}/${P}.patch || die "Patch failed"
}

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	
	rm -rf ${D}/usr/doc
	dohtml ${PN}/docs/en/*.{html,sgml}
	dodoc AUTHORS ChangeLog README TODO
	dodir /usr/share/${PN}/themes
	cp -a theme/* ${D}/usr/share/${PN}/themes/
	chmod go-w ${D}/usr/share/${PN}/themes/
}

pkg_postinst () {
	einfo "emerge icewm-tools for the control center helper tools"
}
