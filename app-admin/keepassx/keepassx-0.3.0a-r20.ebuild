# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.3.0a-r20.ebuild,v 1.3 2008/03/16 12:42:06 opfer Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://keepassx.sourceforge.net/"
SRC_URI="mirror://sourceforge/keepassx/KeePassX-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="( >=x11-libs/qt-4.4.0_rc1:4
	x11-libs/qt-qt3support )"
RDEPEND="${DEPEND}"
S="${WORKDIR}/KeePassX-${PV}"

src_compile() {
	cd "${S}/src"
	lrelease src.pro || die
	mv "${S}"/src/translations/*.qm "${S}"/share/keepassx/i18n
	cd "${S}"
	eqmake4 keepass.pro PREFIX="${D}/usr" ${myconf} || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
}
