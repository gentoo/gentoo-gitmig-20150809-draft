# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/construo/construo-0.2.2.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

DESCRIPTION="2d construction toy with objects that react on physical forces"
HOMEPAGE="http://www.nongnu.org/construo/"
SRC_URI="http://freesoftware.fsf.org/download/construo/construo.pkg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	sys-libs/zlib
	virtual/glut"

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} bindir=/usr/games/bin install || die "make install failed"
	dodoc AUTHORS INSTALL INSTALL.configure NEWS README TODO
	prepgamesdirs
}
