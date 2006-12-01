# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pacmanarena/pacmanarena-0.15.ebuild,v 1.12 2006/12/01 20:32:47 wolf31o2 Exp $

inherit games

DESCRIPTION="a Pacman clone in full 3D with a few surprises. Rockets, bombs and explosions abound."
HOMEPAGE="http://sourceforge.net/projects/pacmanarena/"
SRC_URI="mirror://sourceforge/pacmanarena/pacman-arena-${PV}.tar.bz2
	mirror://sourceforge/pacmanarena/pacman-data-0.0.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE="vorbis"

RDEPEND="virtual/opengl
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-net-1.2.4
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	x11-libs/libXt
	app-arch/unzip"

S=${WORKDIR}/pacman

src_unpack() {
	unpack pacman-arena-${PV}.tar.bz2
	cd "${S}"
	unpack pacman-data-0.0.zip

	sed -i \
		-e "/^CFLAGS/ s:pacman:${PN}:" \
		Makefile.in || die "sed file.h failed"
}

src_install() {
	newgamesbin pacman pacmanarena || die "newgamesbin failed"
	dodir ${GAMES_DATADIR}/${PN}
	cp -r gfx/ sfx/ ${D}${GAMES_DATADIR}/${PN} || die "cp failed"
	dodoc README || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use vorbis ; then
		echo
		ewarn "You need vorbis in your USE var and sdl components build"
		ewarn "with vorbis to have sound."
		echo
	fi
}
