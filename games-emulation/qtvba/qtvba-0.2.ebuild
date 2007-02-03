# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/qtvba/qtvba-0.2.ebuild,v 1.6 2007/02/03 07:27:51 nyhm Exp $

inherit eutils qt3 games

DESCRIPTION="VisualBoyAdvance Frontend"
HOMEPAGE="http://www.apex.net.au/~twalker/qtvba/"
SRC_URI="http://www.apex.net.au/~twalker/qtvba/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3)"
RDEPEND="${DEPEND}
	games-emulation/visualboyadvance"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-Makefilefix.patch"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
