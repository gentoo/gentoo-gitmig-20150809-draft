# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.3.3.12-r1.ebuild,v 1.5 2008/11/21 13:30:04 hanno Exp $

EAPI=1

inherit qt3 eutils cmake-utils

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo cups"

DEPEND="x11-libs/qt:3
	>=media-libs/freetype-2.3
	>=media-libs/lcms-1.17
	>=media-libs/tiff-3.6
	>=media-libs/libart_lgpl-2.3.17
	>=dev-libs/libxml2-2.6.0
	media-libs/jpeg
	media-libs/libpng
	dev-python/imaging
	media-libs/fontconfig
	cups? ( net-print/cups )
	cairo? ( >=x11-libs/cairo-1.4.10 )"

RDEPEND="${DEPEND}
	virtual/ghostscript"

pkg_setup() {
	if ! built_with_use 'x11-libs/cairo' 'X' 'svg'; then
		eerror "You must build cairo with X and svg support"
		die "x11-libs/cairo built without X and/or svg"
	fi
}

src_compile() {
	local mycmakeargs="$(cmake-utils_use_want cairo CAIRO) \
		$(cmake-utils_use_enable cups)"
	cmake-utils_src_compile || die "compile failed"
}

src_install() {
	cmake-utils_src_install

	newmenu "${FILESDIR}/${P}.desktop" "${PN}.desktop" || die "domenu failed"
	doicon scribus/icons/scribusicon.png || die "doicon failed"
}
