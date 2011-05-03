# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cutycapt/cutycapt-0_p20110502-r1.ebuild,v 1.1 2011/05/03 06:47:20 mattm Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="Qt WebKit Web Page Rendering Capture Utility"
HOMEPAGE="http://cutycapt.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~mattm/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"
IUSE=""
DEPEND="x11-libs/libX11 x11-libs/qt-webkit x11-libs/qt-core x11-libs/qt-svg"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 CutyCapt.pro
}

src_compile() {
	emake
}

src_install() {
	dobin CutyCapt
}

pkg_postinst() {
	elog "You cannot use CutyCapt without an X server, but you"
	elog "can use e.g. Xvfb as light-weight server."
	elog "See ${HOMEPAGE} for usage."
}
