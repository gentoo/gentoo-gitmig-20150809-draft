# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.10.ebuild,v 1.1 2003/09/17 18:01:56 msterret Exp $

inherit games

S=${WORKDIR}/tetrinet
DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://achurch.org/tetrinet/"
SRC_URI="http://achurch.org/tetrinet/tetrinet.tar.gz"

LICENSE="as-is"
# don't mark this stable.  There are still issues that need to be worked out.
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5"

src_install() {
	dogamesbin tetrinet tetrinet-server
	dodoc README TODO tetrinet.txt
	prepgamesdirs
}
