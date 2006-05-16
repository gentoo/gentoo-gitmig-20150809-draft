# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/ski/ski-6.5.ebuild,v 1.8 2006/05/16 01:13:25 tcort Exp $

inherit games

DESCRIPTION="A simple text-mode skiing game"
HOMEPAGE="http://www.catb.org/~esr/ski/"
SRC_URI="http://www.catb.org/~esr/ski/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/python"

src_install() {
	dogamesbin ski || die "dogamesbin failed"
	doman ski.6 || die "doman failed"
	dodoc README
	prepgamesdirs
}
