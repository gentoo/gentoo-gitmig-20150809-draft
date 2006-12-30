# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.2.2.ebuild,v 1.6 2006/12/30 17:07:04 opfer Exp $

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

src_compile() {
	if has_version >=x11-libs/qt-4.2.2 && ! built_with_use qt qt3support; then
		eerror
		eerror "You need to rebuild x11-libs/qt with USE=qt3support enabled"
		eerror
		die "please rebuild x11-libs/qt with USE=qt3support"
	fi

	/usr/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin bin/keepass
	insinto /usr/share/
	doins -r share/*
	domenu "${FILESDIR}/keepassx.desktop"
}