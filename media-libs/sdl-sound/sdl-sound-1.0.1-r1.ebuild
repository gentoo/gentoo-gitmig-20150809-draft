# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-1.0.1-r1.ebuild,v 1.1 2004/10/01 06:32:09 mr_bones_ Exp $

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="A library that handles the decoding of sound file formats"
HOMEPAGE="http://icculus.org/SDL_sound/"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="flac mikmod oggvorbis speex physfs"

DEPEND=">=media-libs/libsdl-1.2
	flac? ( media-libs/flac )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	speex? ( media-libs/speex
		media-libs/libogg )
	physfs? ( dev-games/physfs )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--enable-midi \
		--disable-smpeg \
		$(use_enable flac) \
		$(use_enable speex) \
		$(use_enable mikmod) \
		$(use_enable physfs) \
		$(use_enable oggvorbis ogg) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG CREDITS INSTALL README TODO
}
