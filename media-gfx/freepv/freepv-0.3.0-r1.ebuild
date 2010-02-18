# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freepv/freepv-0.3.0-r1.ebuild,v 1.3 2010/02/18 22:07:10 ssuominen Exp $

EAPI=2

inherit cmake-utils nsplugins

DESCRIPTION="Panorama viewer and browser plugin (Quicktime, PangeaVR, GLPanoView)"
HOMEPAGE="http://freepv.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepv/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	net-libs/xulrunner:1.9
	virtual/glut
	sys-libs/zlib
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXxf86vm"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_beta?/}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	epatch "${FILESDIR}"/${P}-xulrunner-1.9.1.patch
	sed -i \
		-e 's:jpeg_mem_src:freepv_jpeg_mem_src:g' \
		src/libfreepv/JpegReader.cpp || die
}

src_install() {
	cmake-utils_src_install

	# Remove plugin and install it in the correct place
	src_mv_plugins /usr/$(get_libdir)/mozilla/plugins
}
