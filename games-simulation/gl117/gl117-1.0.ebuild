# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.0.ebuild,v 1.1 2003/09/11 12:22:49 vapier Exp $

inherit games

MY_P="gl-117-${PV}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="An action flight simulator"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.gz"
HOMEPAGE="http://home.t-online.de/home/primetime./gl-117/"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="sdl"
SLOT="0"

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	virtual/glut"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README || die "dodoc failed"
	prepgamesdirs
}
