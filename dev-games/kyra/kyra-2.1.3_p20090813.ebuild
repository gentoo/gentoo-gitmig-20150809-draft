# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/kyra/kyra-2.1.3_p20090813.ebuild,v 1.2 2009/08/13 06:10:16 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Kyra Sprite Engine"
HOMEPAGE="http://www.grinninglizard.com/kyra/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-build.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opengl"

DEPEND="media-libs/libsdl[opengl?]
	media-libs/sdl-image
	dev-libs/tinyxml
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${WORKDIR}"/${P}-build.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with opengl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
