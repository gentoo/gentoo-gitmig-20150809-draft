# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/robotfindskitten/robotfindskitten-1.4142135.349.ebuild,v 1.6 2004/09/04 23:18:06 dholm Exp $

inherit games

DESCRIPTION="Help robot find kitten"
HOMEPAGE="http://robotfindskitten.org/"
SRC_URI="mirror://sourceforge/rfk/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~ppc"
IUSE=""

DEPEND="sys-libs/ncurses"

src_install() {
	dogamesbin src/robotfindskitten || die "dogamesbin failed"
	doinfo doc/robotfindskitten.info
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
