# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-1.8.5.ebuild,v 1.1 2004/11/06 10:05:15 mr_bones_ Exp $

inherit games

DESCRIPTION="highly addictive and remotely related to tetris"
HOMEPAGE="http://www.karimmi.de/cuyo/"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${P//_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	sys-libs/zlib
	x11-libs/qt"

S="${WORKDIR}/${P/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/^gamesdir.*=/ s:\$(prefix)/games:$(bindir):' \
		-e 's:-O2:@CXXFLAGS@ -Wno-long-long:' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
}

src_compile() {
	egamesconf \
		--with-qt \
		--with-x \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL NEWS README TODO ChangeLog
	prepgamesdirs
}
