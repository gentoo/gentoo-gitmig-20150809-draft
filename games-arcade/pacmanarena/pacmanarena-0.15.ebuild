# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pacmanarena/pacmanarena-0.15.ebuild,v 1.2 2004/03/28 06:02:24 mr_bones_ Exp $

inherit games

S="${WORKDIR}/pacman"
DESCRIPTION="a Pacman clone in full 3D with a few surprises. Rockets, bombs and explosions abound."
HOMEPAGE="http://sourceforge.net/projects/pacmanarena/"
SRC_URI="mirror://sourceforge/pacmanarena/pacman-arena-${PV}.tar.bz2
		mirror://sourceforge/pacmanarena/pacman-data-0.0.zip"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="oggvorbis"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-net-1.2.4
	oggvorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack pacman-arena-${PV}.tar.bz2
	cd ${S}
	unpack pacman-data-0.0.zip

	sed -i \
		-e "/^CFLAGS/ s:pacman:${PN}:" Makefile.in \
			|| die "sed file.h failed"
}

src_install() {
	newgamesbin pacman pacmanarena || die "newgamesbin failed"
	dodir ${GAMES_DATADIR}/${PN}
	cp -r gfx/ sfx/ ${D}${GAMES_DATADIR}/${PN} || die "cp failed"
	dodoc README || die "dodoc failed"
	prepgamesdirs
}

pkg_postins() {
	games_pkg_postinst
	echo
	ewarn "You need oggvorbis in your USE var and sdl components build"
	ewarn "with oggvorbis to have sound."
	echo
}
