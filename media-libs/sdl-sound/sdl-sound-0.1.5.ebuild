# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-0.1.5.ebuild,v 1.13 2004/01/30 12:57:18 mr_bones_ Exp $

IUSE="oggvorbis"

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library that handles the decoding sound file formats"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://icculus.org/SDL_sound/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc "

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/smpeg-0.4.4-r1
	>=media-libs/libmikmod-3.1.9
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {

	econf \
		--enable-midi \
		--disable-flac || die

	emake || die
}

src_install() {

	einstall || die

	dodoc CHANGELOG COPYING CREDITS INSTALL README TODO
}
