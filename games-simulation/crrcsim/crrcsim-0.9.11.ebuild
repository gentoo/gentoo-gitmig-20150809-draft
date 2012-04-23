# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crrcsim/crrcsim-0.9.11.ebuild,v 1.4 2012/04/23 17:36:59 mgorny Exp $

EAPI=3

inherit autotools eutils games

DESCRIPTION="model-airplane flight simulation program"
HOMEPAGE="http://crrcsim.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="portaudio"

RDEPEND="sci-mathematics/cgal
	media-libs/plib
	media-libs/libsdl[X,audio,joystick,opengl,video]
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-buildsystem.patch
	if built_with_use --missing false sci-mathematics/cgal gmp ; then
		epatch "${FILESDIR}"/${PN}-cgal_gmp.patch
	fi

	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_with portaudio)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS HISTORY NEWS README || die

	prepgamesdirs
}
