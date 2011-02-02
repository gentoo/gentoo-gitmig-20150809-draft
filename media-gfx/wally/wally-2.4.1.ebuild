# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.4.1.ebuild,v 1.3 2011/02/02 11:31:18 tampakrap Exp $

EAPI=3
KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="A Qt4/KDE4 wallpaper changer"
HOMEPAGE="http://www.becrux.com/index.php?page=projects&name=wally"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND="
	media-libs/libexif
	x11-libs/qt-svg:4
	kde? ( $(add_kdebase_dep kdelibs) )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.0-disable_popup.patch"
)

src_prepare() {
	kde4-base_src_prepare
	use kde || epatch "${FILESDIR}/${PN}-2.2.0-disable-kde4.patch"
}

src_configure() {
	mycmakeargs=(
		-DSTATIC=FALSE
	)
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
