# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/kyra/kyra-2.0.7.ebuild,v 1.13 2009/01/16 19:55:39 tupone Exp $

inherit eutils

DESCRIPTION="Kyra Sprite Engine"
HOMEPAGE="http://www.grinninglizard.com/kyra/"
SRC_URI="mirror://sourceforge/kyra/kyra_src_${PV//./_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="doc opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-gcc43.patch \
		"${FILESDIR}"/${P}-sdl.patch
}

src_compile() {
	econf $(use_with opengl) || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml docs/*
	use doc && dohtml -r docs/api
}
