# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/codebreaker/codebreaker-1.2.1.ebuild,v 1.3 2004/01/05 21:46:25 aliz Exp $

inherit games

DESCRIPTION="mastermind style game"
HOMEPAGE="http://packages.debian.org/codebreaker"
SRC_URI="mirror://debian/pool/main/c/codebreaker/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.0"

S=${WORKDIR}/${P}.orig

src_install() {
	dogamesbin src/codebreaker
	dodoc README AUTHORS doc/HOWTO
	prepgamesdirs
}
