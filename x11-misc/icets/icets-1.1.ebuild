# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icets/icets-1.1.ebuild,v 1.6 2004/03/24 11:29:07 phosphan Exp $

DESCRIPTION="IceWM Theme Editor"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/qt-3.0.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {

	unpack ${A}
	cd ${S}/${PN}

	# Change the default directory that it looks into to be consistent
	# with Gentoo's layout
	sed -i -e "s:/usr/local/share/icewm/themes:/usr/share/icewm/themes:" \
		icets.cpp
}

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml icets/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING ChangeLog README TODO
}
