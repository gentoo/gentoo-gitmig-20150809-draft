# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crrcsim/crrcsim-0.9.11.ebuild,v 1.1 2011/11/12 00:01:24 xmw Exp $

EAPI=3

inherit autotools eutils games

DESCRIPTION="model-airplane flight simulation program"
HOMEPAGE="http://crrcsim.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="portaudio"

RDEPEND="media-libs/plib
	media-libs/libsdl[X,audio,joystick,opengl,video]
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-buildsystem.patch

	eautoreconf
}

src_configure() {
	econf $(use_with poraudio) $(use_with sdl)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS HISTORY NEWS README || die

	prepgamesdirs
}
