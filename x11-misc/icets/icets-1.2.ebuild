# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icets/icets-1.2.ebuild,v 1.3 2004/08/03 11:25:05 dholm Exp $

DESCRIPTION="IceWM Theme Editor"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=x11-libs/qt-3.0.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local/bin:/usr/bin:" -i ${PN}.pro || die "sed failed"
	sed -e 's:/usr/local/share:/usr/share:g' -i ${PN}.cpp || die "sed failed"
}

src_compile () {
	qmake || die
	emake || die
}

src_install () {
	make INSTALL_ROOT="${D}" install || die

	rm -rf ${D}/usr/doc
	dohtml icets/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING ChangeLog README TODO
}
