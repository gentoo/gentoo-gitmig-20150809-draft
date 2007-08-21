# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.2.2-r1.ebuild,v 1.2 2007/08/21 11:20:15 opfer Exp $

inherit eutils

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://keepassx.sourceforge.net/"
SRC_URI="mirror://sourceforge/keepassx/KeePassX-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=x11-libs/qt-4.1"
RDEPEND="${DEPEND}"

pkg_setup() {
	if has_version ">=x11-libs/qt-4.2.2" && ! built_with_use x11-libs/qt qt3support; then
		eerror
		eerror "You need to rebuild x11-libs/qt with USE=qt3support enabled"
		eerror
		die "please rebuild x11-libs/qt with USE=qt3support"
	fi
}

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
