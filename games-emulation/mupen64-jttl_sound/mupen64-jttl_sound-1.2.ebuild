# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-jttl_sound/mupen64-jttl_sound-1.2.ebuild,v 1.1 2005/01/06 02:33:19 morfic Exp $

inherit games gcc eutils libtool

IUSE="sdl"

DESCRIPTION="A sound plugin for mupen64"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/jttl_sound-1.2.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="media-libs/libsdl
	media-libs/sdl-sound"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/jttl_sound-1.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo-sdl.patch
	sed -i -e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" Makefile ||  \
		die "couldn't apply cflags"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	local dir=${GAMES_LIBDIR}/mupen64
	dodir ${dir}

	exeinto ${dir}/plugins
	doexe *.so
	cp jttl_audio.conf ${D}/${dir}/plugins

	dodoc README

	prepgamesdirs
}

