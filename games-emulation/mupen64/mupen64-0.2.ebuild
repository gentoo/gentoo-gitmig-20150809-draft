# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.2.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games

MY_P="${PN}_src-${PV}"
S="${WORKDIR}/emu64"
DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/files/src/${MY_P}.tgz"
HOMEPAGE="http://mupen64.emulation64.com/"

KEYWORDS="-* x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	>=sys-apps/sed-4
	media-libs/libsdl
	virtual/glu
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CC.*/s:$: ${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}
	dodir ${dir}

	cp -r mupen64* lang plugins save roms path.cfg ${D}/${dir}/
	sed -e "s:GENTOO_DIR:${dir}:" \
		${FILESDIR}/mupen64 > ${T}/mupen64
	dogamesbin ${T}/mupen64

	dodoc *.txt
	dohtml index.htm

	prepgamesdirs
}
