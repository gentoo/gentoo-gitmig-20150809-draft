# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/twclone/twclone-0.14.ebuild,v 1.2 2004/03/26 23:21:12 dholm Exp $

inherit games

MY_P="${PN}-source-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Clone of BBS Door game Trade Wars 2002"
HOMEPAGE="http://twclone.sourceforge.net/"
SRC_URI="mirror://sourceforge/twclone/${MY_P}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog PROTOCOL README TODO
	cd ${D}/${GAMES_BINDIR}
	for f in * ; do
		mv {,${PN}-}${f}
	done
	prepgamesdirs
}
