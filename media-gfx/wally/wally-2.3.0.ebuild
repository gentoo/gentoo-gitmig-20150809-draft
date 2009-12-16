# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.3.0.ebuild,v 1.2 2009/12/16 21:18:41 maekke Exp $

EAPI="2"

KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://wally.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="media-libs/libexif
	x11-libs/qt-svg:4
	kde? (	>=kde-base/kdelibs-4.2.0 )"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.0-disable_popup.patch"
	)

src_prepare() {
	kde4-base_src_prepare
	! use kde && epatch "${FILESDIR}/${PN}-2.2.0-disable-kde4.patch"
}

src_install() {
	cmake-utils_src_install
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
