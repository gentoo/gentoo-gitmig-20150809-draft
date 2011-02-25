# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20100726.ebuild,v 1.4 2011/02/25 22:18:55 signals Exp $

EAPI=2
inherit eutils games

MY_PN=alienarena7_45
DESCRIPTION="Fast-paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://icculus.org/alienarena/Files/${MY_PN}-Linux${PV}.zip"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

UIRDEPEND="virtual/jpeg
	media-libs/openal
	media-libs/libvorbis
	virtual/glu
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
RDEPEND="opengl? ( ${UIRDEPEND} )
	!opengl? ( !dedicated? ( ${UIRDEPEND} ) )
	net-misc/curl"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto"
DEPEND="${RDEPEND}
	opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}/source

src_prepare() {
	rm -f ../*/*.so
	sed -i \
		-e 's:\($(SHLIBLDFLAGS)\):$(LDFLAGS) \1:' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		ARCH="unknown" \
		OSTYPE="linux" \
		OPTIMIZED_CFLAGS=no \
		WITH_DATADIR=yes \
		WITH_LIBDIR=yes \
		DATADIR="${GAMES_DATADIR}"/${PN} \
		LIBDIR="$(games_get_libdir)"/${PN} \
		$(use opengl && ! use dedicated && echo BUILD=CLIENT) \
		$(! use opengl && use dedicated && echo BUILD=DEDICATED) \
		$(use opengl && use dedicated && echo BUILD=ALL) \
		$(use opengl || use dedicated || echo BUILD=CLIENT) \
		|| die "emake failed"
}

src_install() {
	cd release
	exeinto "$(games_get_libdir)"/${PN}
	doexe game.so || die "doexe failed"
	dosym . "$(games_get_libdir)"/${PN}/arena
	dosym . "$(games_get_libdir)"/${PN}/data1

	if use opengl || ! use dedicated ; then
		newgamesbin crx ${PN} || die "newgamesbin crx failed"
		make_desktop_entry ${PN} "Alien Arena"
	fi

	if use dedicated ; then
		newgamesbin crded ${PN}-ded || die "newgamesbin crded failed"
	fi

	cd "${WORKDIR}"/${MY_PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arena botinfo data1 || die "doins failed"
	newicon aa.png ${PN}.png || die "newicon failed"
	dodoc docs/README.txt

	prepgamesdirs
}
