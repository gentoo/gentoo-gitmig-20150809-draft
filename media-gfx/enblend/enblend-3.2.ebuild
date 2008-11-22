# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-3.2.ebuild,v 1.4 2008/11/22 23:40:12 maekke Exp $

inherit eutils

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI="mirror://sourceforge/enblend/${PN}-enfuse-${PV}.tar.gz"

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-libs/boost-1.31.0
	media-libs/lcms
	media-libs/glew
	media-libs/plotutils
	media-libs/tiff
	virtual/glut"

S="${WORKDIR}/${PN}-enfuse-${PV}"

pkg_setup() {
	# bug 202476
	if ! built_with_use media-libs/plotutils X ; then
		eerror
		eerror "media-gfx/plotutils has to be built with USE=\"X\""
		eerror
		die "emerge plotutils with USE=\"X\""
	fi

	ewarn
	ewarn "The compilation of enblend needs a lot of RAM. If you have less"
	ewarn "than 1GB RAM (and swap) you probably won't be able to compile it."
	ewarn
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:-O3::' configure || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
