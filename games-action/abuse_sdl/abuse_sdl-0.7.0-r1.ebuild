# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse_sdl/abuse_sdl-0.7.0-r1.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games eutils

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://www.labyrinth.net.au/~trandor/abuse/"
SRC_URI="http://www.labyrinth.net.au/~trandor/abuse/files/${P}.tar.bz2
	http://www.labyrinth.net.au/~trandor/abuse/files/abuse_datafiles.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	>=media-libs/libsdl-1.1.6"

DATA=${WORKDIR}/datafiles

src_unpack() {
	cd ${WORKDIR}
	mkdir ${DATA}
	cd ${DATA}
	unpack abuse_datafiles.tar.gz
	cd ${WORKDIR}
	unpack ${P}.tar.bz2
}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO

	cd ${DATA}
	dodir ${GAMES_DATADIR}/abuse
	cp -r * ${D}/${GAMES_DATADIR}/abuse

	#fix for #10573 + #11475 ... stupid hippy bug
	cd ${D}/${GAMES_DATADIR}/abuse
	epatch ${FILESDIR}/stupid-fix.patch

	prepgamesdirs
}
