# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/nighthawk/nighthawk-2.2.ebuild,v 1.11 2007/06/13 15:00:14 nyhm Exp $

inherit eutils games

DESCRIPTION="A tribute to one of the most playable and contagious games ever written- Paradroid by Andrew Braybrook"
HOMEPAGE="http://night-hawk.sourceforge.net/nighthawk.html"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/arcade/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/nighthawk.patch \
		"${FILESDIR}"/${P}-gcc42.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
