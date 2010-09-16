# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.5.0-r1.ebuild,v 1.3 2010/09/16 18:13:42 scarabeus Exp $

EAPI="2"

inherit base

DESCRIPTION="The glue between Coin3D and Qt"
SRC_URI="http://ftp.coin3d.org/coin/src/all/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc static-libs"

RDEPEND="
	>=media-libs/coin-3.1.3
	virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
"

PATCHES=(
	"${FILESDIR}/${PN}-1.5.0-pkgconfig-partial.patch"
)

DOCS=(AUTHORS ChangeLog FAQ HACKING NEWS README)

src_configure() {
	econf \
		htmldir="/usr/share/doc/${PF}/html" \
		--disable-compact \
		--disable-html-help \
		--disable-loadlibrary \
		--disable-man \
		--enable-pkgconfig \
		--includedir="/usr/include/coin" \
		--with-coin \
		$(use_enable debug) \
		$(use_enable debug symbols) \
		$(use_enable doc html) \
		$(use_enable static-libs static)
}

src_install() {
	# Remove SoQt from Libs.private
	sed -e '/Libs.private/s/ -lSoQt//' -i SoQt.pc || die

	base_src_install

	# Remove libtool files when not needed.
	use static-libs || rm -f "${D}"/usr/lib*/*.la
}
