# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/twclone/twclone-0.12.ebuild,v 1.2 2004/02/03 20:41:56 mr_bones_ Exp $

inherit eutils games

MY_P="${PN}-source-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Clone of BBS Door game Trade Wars 2002"
HOMEPAGE="http://twclone.sourceforge.net/"
SRC_URI="mirror://sourceforge/twclone/${MY_P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-glibc-sendmsg.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS PROTOCOL README TODO
	cd ${D}/${GAMES_BINDIR}
	for f in * ; do
		mv {,${PN}-}${f}
	done
	prepgamesdirs
}
