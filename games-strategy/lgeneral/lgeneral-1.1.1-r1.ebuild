# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.1.1-r1.ebuild,v 1.4 2004/04/06 06:59:17 mr_bones_ Exp $

inherit eutils games

DATA=lgeneral-data-1.1.3

DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/lgeneral/${P}.tar.gz
	mirror://sourceforge/lgeneral/${DATA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-netbsd-audio.patch"
}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR}/../
	emake || die "emake failed"

	cd ${WORKDIR}/${DATA}
	egamesconf --datadir=${GAMES_DATADIR}/../
	emake || die "emake failed (data)"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	cd ${WORKDIR}/${DATA}
	make DESTDIR=${D} install || die "make install failed (data)"
	prepgamesdirs
}
