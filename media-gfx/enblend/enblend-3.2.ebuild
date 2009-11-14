# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-3.2.ebuild,v 1.8 2009/11/14 20:38:31 maekke Exp $

EAPI=2

inherit eutils

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI="mirror://sourceforge/enblend/${PN}-enfuse-${PV}.tar.gz"

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	media-libs/lcms
	media-libs/glew
	media-libs/plotutils[X]
	media-libs/tiff
	virtual/glut"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.31.0"

S="${WORKDIR}/${PN}-enfuse-${PV}"

pkg_setup() {
	ewarn
	ewarn "Please note: the compilation of enblend needs about 1 GB RAM (and swap)."
	ewarn
}

src_prepare() {
	sed -i -e 's:-O3::' configure || die
}

src_compile() {
	# forcing -j1 as every parallel compilation process needs about 1 GB RAM.
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
