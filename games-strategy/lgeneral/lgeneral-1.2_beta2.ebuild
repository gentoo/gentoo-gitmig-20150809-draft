# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2_beta2.ebuild,v 1.2 2004/06/24 23:28:14 agriffis Exp $

inherit eutils games

DATA=lgeneral-data-1.1.3
MY_P="${P/_/}"
MY_P="${MY_P/beta/beta-}"
DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/lgeneral/${MY_P}.tar.gz
	mirror://sourceforge/lgeneral/${DATA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

S="${WORKDIR}/${MY_P}"

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR}/../"
	emake || die "emake failed"

	cd "${WORKDIR}/${DATA}"
	egamesconf --datadir="${GAMES_DATADIR}/../"
	emake || die "emake failed (data)"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	cd "${WORKDIR}/${DATA}"
	make DESTDIR="${D}" install || die "make install failed (data)"
	prepgamesdirs
}
