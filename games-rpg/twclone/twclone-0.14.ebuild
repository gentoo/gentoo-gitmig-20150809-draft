# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/twclone/twclone-0.14.ebuild,v 1.3 2004/06/03 22:30:58 jhuebel Exp $

inherit games

MY_P="${PN}-source-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Clone of BBS Door game Trade Wars 2002"
HOMEPAGE="http://twclone.sourceforge.net/"
SRC_URI="mirror://sourceforge/twclone/${MY_P}.tar.gz"

KEYWORDS="x86 ~ppc ~amd64"
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
