# Copyriht 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-0.1.5.ebuild,v 1.1 2002/05/06 14:56:56 seemant Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library that handles the decoding sound file formats"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://icculus.org/SDL_sound/"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.4
	>=media-libs/smpeg-0.4.4-r1
	>=media-libs/libmikmod-3.1.9
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"


src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-midi \
		--disable-flac || die
		
	emake || die
}

src_install() {

	einstall || die
	
	dodoc CHANGELOG COPYING CREDITS INSTALL README TODO
}
