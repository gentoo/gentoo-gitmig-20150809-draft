# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.3j.ebuild,v 1.4 2004/03/31 18:40:59 eradicator Exp $

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="http://www.mcmilk.de/projects/mcdp/dl/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="dev-libs/dietlibc"

src_compile() {
	make || die
}

src_install() {
	dobin mcdp || die
	doman mcdp.1 || die

	cd doc
	dodoc CHANGES INSTALL README THANKS profile.sh
}
