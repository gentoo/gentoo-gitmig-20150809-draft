# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/robotfindskitten/robotfindskitten-1.4142135.349.ebuild,v 1.1 2004/01/03 22:32:18 vapier Exp $

inherit games

DESCRIPTION="Help robot find kitten"
HOMEPAGE="http://robotfindskitten.org/"
SRC_URI="mirror://sourceforge/rfk/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"

DEPEND="sys-libs/ncurses"

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	dogamesbin src/robotfindskitten
	doinfo doc/robotfindskitten.info
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
