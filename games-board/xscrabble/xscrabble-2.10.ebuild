# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xscrabble/xscrabble-2.10.ebuild,v 1.2 2004/01/31 05:48:27 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="An X11 clone of the well-known Scrabble"
HOMEPAGE="http://freshmeat.net/projects/xscrabble/?topic_id=80"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/educational_games/${P}.tgz
	nls? ( ftp://ftp.ac-grenoble.fr/ge/educational_games/xscrabble_fr.tgz )
	ftp://ftp.ac-grenoble.fr/ge/educational_games/xscrabble_en.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${P}.tgz

	cp ${DISTDIR}/xscrabble_en.tgz .
	[ `use nls` ] && cp ${DISTDIR}/xscrabble_fr.tgz .

	cd ${S}
	epatch ${FILESDIR}/${PV}-path-fixes.patch
}

src_compile() {
	./build bin || die
}

src_install() {
	export DESTDIR=${D}
	./build install || die
	[ `use nls` ] && { ./build lang fr || die; }
	./build lang en || die
	for f in ${D}/usr/X11R6/lib/X11/app-defaults/* ; do
		sed -i "s:/usr/games/lib/scrabble/:${GAMES_DATADIR}/${PN}/:" ${f}
	done
	dodoc CHANGES README
	prepgamesdirs
}
