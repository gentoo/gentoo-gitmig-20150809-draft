# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.0.3.ebuild,v 1.2 2009/05/08 11:29:32 hwoarang Exp $

EAPI="2"
inherit eutils cmake-utils qt4

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://wally.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND="media-libs/libexif
	x11-libs/qt-svg:4
	kde? (	>=kde-base/kdelibs-4.2.0 )"

RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/wallyplugin/"
CMAKE_IN_SOURCE_BUILD="1"

src_configure() {
	eqmake4
	if use kde; then
		cmake-utils_src_configure
	fi
}

src_compile() {
	emake || die "emake failed"
	if use kde; then
		cmake-utils_src_compile
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	if use kde;then
		cmake-utils_src_install
	fi
	newicon "${S}"/res/images/idle.png wally.png
	make_desktop_entry wally Wally wally "Graphics;Qt"
}

pkg_postinst() {
	if use kde;then
		elog
		elog "In order to use wallyplugin you need to"
		elog "restart plasma on your KDE4 enviroment."
		elog
	fi
}
