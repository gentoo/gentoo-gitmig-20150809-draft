# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/qtvba/qtvba-0.2.ebuild,v 1.5 2005/02/14 09:34:56 mr_bones_ Exp $

inherit eutils kde-functions

DESCRIPTION="VisualBoyAdvance Frontend"
HOMEPAGE="http://www.apex.net.au/~twalker/qtvba/"
SRC_URI="http://www.apex.net.au/~twalker/qtvba/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=">=games-emulation/visualboyadvance-1.5.1"
need-qt 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-Makefilefix.patch"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
