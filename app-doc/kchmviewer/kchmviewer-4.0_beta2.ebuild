# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-4.0_beta2.ebuild,v 1.3 2008/05/13 07:44:52 pva Exp $

EAPI="1"
inherit qt4 fdo-mime

MY_P="${PN}-${PV/_beta/beta}"

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	|| ( x11-libs/qt-gui:4 >=x11-libs/qt-4.2 )
	dev-libs/chmlib"

S=${WORKDIR}/${MY_P}

src_compile() {
	eqmake4
	emake || die "make failed"
}

src_install() {
	dobin bin/kchmviewer || die "dobin kchmviewer failed"
	insinto /usr/share/applications
	doins lib/kio-msits/kchmviewer.desktop
	dodoc ChangeLog README DCOP-bingings FAQ
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
