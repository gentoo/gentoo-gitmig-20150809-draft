# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/twclone/twclone-0.12.ebuild,v 1.1 2003/10/25 10:21:09 vapier Exp $

inherit games

MY_P=${PN}-source-${PV}
DESCRIPTION="Clone of BBS Door game Trade Wars 2002"
HOMEPAGE="http://twclone.sourceforge.net/"
SRC_URI="mirror://sourceforge/twclone/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-glibc-sendmsg.patch
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS PROTOCOL README TODO
	cd ${D}/${GAMES_BINDIR}
	for f in * ; do
		mv {,${PN}-}${f}
	done
	prepgamesdirs
}
