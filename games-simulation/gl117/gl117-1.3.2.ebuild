# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.3.2.ebuild,v 1.9 2010/07/12 20:35:53 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_P="gl-117-${PV}-src"
DESCRIPTION="An action flight simulator"
HOMEPAGE="http://www.heptargon.de/"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,joystick,opengl,video]
	media-libs/sdl-mixer[mikmod]
	virtual/opengl
	virtual/glu
	virtual/glut"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon doc/src/falcon.jpg ${PN}.jpg
	make_desktop_entry gl-117 GL-117 /usr/share/pixmaps/${PN}.jpg
	doman doc/gl-117.6
	dodoc doc/gl-117.pdf AUTHORS ChangeLog FAQ NEWS README
	prepgamesdirs
}
