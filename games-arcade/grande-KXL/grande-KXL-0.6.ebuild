# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/grande-KXL/grande-KXL-0.6.ebuild,v 1.3 2004/04/27 08:07:13 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="ZANAC type game"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-games/KXL-1.1.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-configure.in.patch
	autoconf || die
}

src_compile() {
	egamesconf \
		--datadir=${GAMES_DATADIR_BASE} \
		|| die
	emake || die
}

src_install() {
	dodir ${GAMES_STATEDIR}
	make DESTDIR=${D} install || die
	dodoc ChangeLog README
	prepgamesdirs
}
