# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-1.6.1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

S=${WORKDIR}/${P/_}
DESCRIPTION="highly addictive and remotely related to tetris"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${P//_}.tar.gz"
HOMEPAGE="http://www.karimmi.de/cuyo/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/qt-2*"

src_compile() {
	egamesconf \
		--with-qt \
		--with-qt-dir=/usr/qt/2 \
		--with-x \
		|| die
	emake || die
}

src_install() {
	cp data/Makefile{,.old}
	sed -e 's: $(pkgdatadir: $(DESTDIR)$(pkgdatadir:' \
		data/Makefile.old > data/Makefile
	make install DESTDIR=${D} || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO ChangeLog

	prepgamesdirs
}
