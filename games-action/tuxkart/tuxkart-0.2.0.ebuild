# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/tuxkart/tuxkart-0.2.0.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games eutils

DESCRIPTION="A racing game starring Tux, the linux penguin"
SRC_URI="mirror://sourceforge/tuxkart/${P}.tar.gz"
HOMEPAGE="http://tuxkart.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/plib-1.6.0
	virtual/x11
	virtual/glut
	virtual/opengl"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/01tuxkart.patch
}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/tuxkart/

	dodoc AUTHORS  CHANGES  COPYING  LICENSE  NEWS  README
	dohtml doc/*.html

	prepgamesdirs
}
