# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freepv/freepv-0.3.0.ebuild,v 1.2 2009/06/13 20:54:39 voyageur Exp $

EAPI=2

inherit cmake-utils nsplugins

DESCRIPTION="Panorama viewer and browser plugin (Quicktime, PangeaVR, GLPanoView)"
HOMEPAGE="http://freepv.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepv/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	net-libs/xulrunner
	virtual/glut
	sys-libs/zlib
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXxf86vm"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_beta?/}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_install() {
	cmake-utils_src_install

	# Remove plugin and install it in the correct place
	src_mv_plugins /usr/$(get_libdir)/mozilla/plugins
}
