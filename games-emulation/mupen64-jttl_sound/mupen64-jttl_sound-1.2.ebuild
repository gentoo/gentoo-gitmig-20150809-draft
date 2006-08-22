# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-jttl_sound/mupen64-jttl_sound-1.2.ebuild,v 1.7 2006/08/22 08:11:40 mr_bones_ Exp $

inherit eutils libtool games

DESCRIPTION="A sound plugin for mupen64"
SRC_URI="http://mupen64.emulation64.com/files/0.4/jttl_sound-1.2.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl"

DEPEND="media-libs/libsdl
	media-libs/sdl-sound"

S=${WORKDIR}/jttl_sound-1.2

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-gentoo-sdl.patch
	sed -i \
		-e '/strip/d' \
		-e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	local dir=${GAMES_LIBDIR}/mupen64

	exeinto "${dir}"/plugins
	doexe *.so
	cp jttl_audio.conf "${D}/${dir}/plugins" || die "cp failed"
	dodoc README
	prepgamesdirs
}
