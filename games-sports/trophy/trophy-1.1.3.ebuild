# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trophy/trophy-1.1.3.ebuild,v 1.3 2004/03/19 21:01:55 vapier Exp $

inherit games

MY_P="${P}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="2D Racing Game"
HOMEPAGE="http://trophy.sourceforge.net/"
SRC_URI="mirror://sourceforge/trophy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=dev-games/clanlib-0.6.5*
	>=media-libs/hermes-1.3.2
	>=sys-libs/zlib-1.1.3"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}
	find -name ".cvsignore" -exec rm -f \{\} \;
}

src_compile() {
	cd trophy
	autoconf || die "autoconf failed"
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin trophy/trophy || die
	dodir ${GAMES_DATADIR}/trophy/resources
	cp -R trophy/resources/* ${D}${GAMES_DATADIR}/trophy/resources
	cp trophy/resources.scr ${D}${GAMES_DATADIR}/trophy/
	dodoc AUTHORS README TODO ChangeLog
	prepgamesdirs
}
