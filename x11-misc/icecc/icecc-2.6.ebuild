# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-2.6.ebuild,v 1.3 2004/03/24 11:19:51 phosphan Exp $

inherit eutils

DESCRIPTION="IceWM Control Center (only main program, see icewm-tools for the rest)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
SLOT="0"

DEPEND=">=x11-libs/qt-3.0.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml ${PN}/docs/en/*.{html,sgml}
	dodoc AUTHORS ChangeLog README TODO
	dodir /usr/share/${PN}/themes
	cp -a theme/* ${D}/usr/share/${PN}/themes/
	chmod go-w ${D}/usr/share/${PN}/themes/
}

pkg_postinst() {
	einfo "emerge icewm-tools for the control center helper tools"
}
