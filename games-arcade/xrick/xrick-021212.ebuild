# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xrick/xrick-021212.ebuild,v 1.1 2003/09/10 19:29:22 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Clone of the Rick Dangerous adventure game from the 80's"
SRC_URI="http://www.bigorno.net/xrick/${P}.tgz"
HOMEPAGE="http://www.bigorno.net/xrick/"
KEYWORDS="x86"

SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libsdl-1.2"

src_compile() {
	emake || die
	gunzip xrick.6.gz
}

src_install () {
	dobin xrick
	dodoc README KeyCodes
	doman xrick.6
}
