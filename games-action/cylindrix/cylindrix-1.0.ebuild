# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/cylindrix/cylindrix-1.0.ebuild,v 1.4 2006/01/28 21:19:10 joshuabaergen Exp $

inherit games

DESCRIPTION="Action game in a tube"
HOMEPAGE="http://www.hardgeus.com/cylindrix/"
SRC_URI="http://www.hardgeus.com/cylindrix/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/g_DataPath/s:\./:${GAMES_DATADIR}/${PN}/:" sb_stub.c \
		|| die "sed sb_stub.c failed"
	find -name CVS -exec rm -rf '{}' \; >& /dev/null
}

src_install() {
	make install DESTDIR=${D} || die
	insinto ${GAMES_DATADIR}/${PN}
	doins people.dat cylindrx.fli
	for d in 3d_data gamedata pcx_data ; do
		insinto ${GAMES_DATADIR}/${PN}/${d}
		doins ${d}/*
	done
	cp -r wav_data ${D}/${GAMES_DATADIR}/${PN}/

	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
	fperms g+w ${GAMES_DATADIR}/${PN}/gamedata/game.cfg
}
