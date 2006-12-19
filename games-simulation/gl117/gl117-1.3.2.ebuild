# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.3.2.ebuild,v 1.6 2006/12/19 22:52:11 mr_bones_ Exp $

inherit eutils games

MY_P="gl-117-${PV}-src"
DESCRIPTION="An action flight simulator"
HOMEPAGE="http://www.heptargon.de/"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	virtual/glut"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		die "Please emerge sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README
	prepgamesdirs
}
