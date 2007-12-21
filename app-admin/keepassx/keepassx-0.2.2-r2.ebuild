# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.2.2-r2.ebuild,v 1.1 2007/12/21 08:27:17 opfer Exp $

inherit eutils

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://keepassx.sourceforge.net/"
SRC_URI="mirror://sourceforge/keepassx/KeePassX-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="( >=x11-libs/qt-4.4.0_rc1
	x11-libs/qt-qt3support )"
RDEPEND="${DEPEND}"

src_compile() {
	/usr/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin bin/keepass

	insinto /usr/share/
	doins -r share/*

	dosym /usr/share/keepass/icons/${PN}.png \
		/usr/share/pixmaps/${PN}.png

	domenu "${FILESDIR}/${PN}.desktop"
}
