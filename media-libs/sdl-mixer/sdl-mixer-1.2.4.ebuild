# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-mixer/sdl-mixer-1.2.4.ebuild,v 1.12 2003/09/06 23:59:48 msterret Exp $

IUSE="mpeg mikmod oggvorbis"

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Direct Media Layer Mixer Library"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/smpeg-0.4.4-r1
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"


src_compile() {

	local myconf

	use mikmod || myconf="${myconf} --disable-mod"
	use mpeg || myconf="${myconf} --disable-music-mp3"
	use oggvorbis || myconf="${myconf} --disable-music-ogg"

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc CHANGES COPYING README
}
