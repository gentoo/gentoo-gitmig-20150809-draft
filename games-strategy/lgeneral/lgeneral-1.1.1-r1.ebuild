# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.1.1-r1.ebuild,v 1.2 2004/02/03 00:14:43 mr_bones_ Exp $

inherit games

DATA=lgeneral-data-1.1.3

DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/lgeneral/${P}.tar.gz
	mirror://sourceforge/lgeneral/${DATA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR}/../
	emake || die

	cd ${WORKDIR}/${DATA}
	egamesconf --datadir=${GAMES_DATADIR}/../
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL README TODO

	cd ${WORKDIR}/${DATA}
	make DESTDIR=${D} install || die

	prepgamesdirs
}
