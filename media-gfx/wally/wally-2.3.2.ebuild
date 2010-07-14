# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.3.2.ebuild,v 1.6 2010/07/14 13:29:33 fauli Exp $

EAPI="2"
KDE_REQUIRED="optional"
inherit cmake-utils kde4-base

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://www.becrux.com/index.php?page=projects&name=wally"
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
	"${FILESDIR}/${P}-disable-plugins.patch"
)

src_prepare() {
	kde4-base_src_prepare
	use kde || epatch "${FILESDIR}/${PN}-2.2.0-disable-kde4.patch"
}

src_configure() {
	mycmakeargs="${mycmakeargs} -DSTATIC=FALSE"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newicon "${S}"/res/images/idle.png wally.png || die
	make_desktop_entry wally Wally wally "Graphics;Qt"
}

pkg_postinst() {
	if use kde; then
		elog
		elog "In order to use wallyplugin you need to"
		elog "restart plasma in your KDE4 enviroment."
		elog
	fi
}
