# Copyriht 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-mixer/sdl-mixer-1.2.0-r1.ebuild,v 1.1 2001/09/22 22:48:28 lordjoe Exp $

A=SDL_mixer-${PV}.tar.gz
S=${WORKDIR}/SDL_mixer-${PV}
DESCRIPTION="Simple Direct Media Layer Mixer Library"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${A}"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/index.html"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.0
	>=media-libs/smpeg-0.4.3
	ogg? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man || die
  try emake || die
}

src_install() {
  cd ${S}
  try make DESTDIR=${D} install || die
  preplib /usr
  dodoc CHANGES COPYING README  
}
