# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.1.ebuild,v 1.2 2004/02/04 20:09:55 dholm Exp $

inherit games

MY_P="gl-117-${PV}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="An action flight simulator"
HOMEPAGE="http://home.t-online.de/home/primetime./gl-117/"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="sdl"

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	virtual/glut"

src_install() {
	make DESTDIR="${D}" install             || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README || die "dodoc failed"
	prepgamesdirs
}
