# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-1.8.1.ebuild,v 1.3 2004/02/03 00:41:11 mr_bones_ Exp $

inherit games

S=${WORKDIR}/${P/_}
DESCRIPTION="highly addictive and remotely related to tetris"
HOMEPAGE="http://www.karimmi.de/cuyo/"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${P//_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/qt-2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-O2:@CXXFLAGS@:' src/Makefile.in
}

src_compile() {
#	local qtver=
#	has_version =x11-libs/qt-3* \
#		&& qtver=3 \
#		|| qtver=2
	qtver=2
	egamesconf \
		--with-qt \
		--with-qt-dir=/usr/qt/${qtver} \
		--with-x \
		|| die
	emake || die
}

src_install() {
	sed -i \
		's: $(pkgdatadir: $(DESTDIR)$(pkgdatadir:' \
		data/Makefile
	make install DESTDIR=${D} || die
	dogamesbin ${D}/${GAMES_PREFIX}/games/cuyo
	rm -rf ${D}/${GAMES_PREFIX}/games
	dodoc AUTHORS INSTALL NEWS README TODO ChangeLog

	prepgamesdirs
}
