# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/jugglemaster/jugglemaster-0.3.ebuild,v 1.4 2004/06/24 22:57:46 agriffis Exp $

DESCRIPTION="A siteswap animator"
HOMEPAGE="http://icculus.org/jugglemaster/"
SRC_URI="http://icculus.org/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND="x11-libs/wxGTK"

src_compile() {
	cd src/jmdlx
	emake || die "emake failed"
}

src_install () {
	dobin src/jmdlx/jmdlx || die "dobin failed"
	dodoc ChangeLog README TODO
}
