# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.3.0a.ebuild,v 1.3 2008/03/16 12:42:06 opfer Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://keepassx.sourceforge.net/"
SRC_URI="mirror://sourceforge/keepassx/KeePassX-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"
DEPEND=">=x11-libs/qt-4.1:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/KeePassX-${PV}"

pkg_setup() {
	if ! built_with_use --missing true x11-libs/qt qt3support png; then
		eerror
		eerror "You need to rebuild x11-libs/qt with USE=qt3support and png enabled"
		eerror
		die "please rebuild x11-libs/qt with USE=\"qt3support png\""
	fi
}

src_compile() {
	cd "${S}/src"
	lrelease src.pro || die
	mv "${S}"/src/translations/*.qm "${S}"/share/keepassx/i18n
	cd "${S}"
	use debug || myconf="DEBUG=1"
	eqmake4 keepass.pro PREFIX="${D}/usr" ${myconf}|| die
	emake || die
}

src_install(){
	emake install || die
}
