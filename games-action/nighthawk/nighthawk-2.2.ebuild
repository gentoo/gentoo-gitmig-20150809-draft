# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/nighthawk/nighthawk-2.2.ebuild,v 1.7 2005/03/09 17:22:19 luckyduck Exp $

inherit eutils games

DESCRIPTION="A tribute to one of the most playable and contagious games ever written- Paradroid by Andrew Braybrook"
HOMEPAGE="http://night-hawk.sourceforge.net/nighthawk.html"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/arcade/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~amd64"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/nighthawk.patch"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
