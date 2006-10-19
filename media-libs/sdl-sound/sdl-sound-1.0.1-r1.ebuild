# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-1.0.1-r1.ebuild,v 1.6 2006/10/19 17:38:05 flameeyes Exp $

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="A library that handles the decoding of sound file formats"
HOMEPAGE="http://icculus.org/SDL_sound/"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="flac mikmod vorbis speex physfs"

DEPEND=">=media-libs/libsdl-1.2
	flac? ( ~media-libs/flac-1.1.2 )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	speex? ( media-libs/speex
		media-libs/libogg )
	physfs? ( dev-games/physfs )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--enable-midi \
		--disable-smpeg \
		$(use_enable flac) \
		$(use_enable speex) \
		$(use_enable mikmod) \
		$(use_enable physfs) \
		$(use_enable vorbis ogg) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG CREDITS README TODO
}
