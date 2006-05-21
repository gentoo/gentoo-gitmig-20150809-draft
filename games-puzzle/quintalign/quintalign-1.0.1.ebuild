# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quintalign/quintalign-1.0.1.ebuild,v 1.1 2006/05/21 10:47:23 tupone Exp $

inherit kde
need-kde 3

DESCRIPTION="A one player boardgame - similar to Tetris"
HOMEPAGE="http://www.heni-online.de/linux/"
SRC_URI="http://www.heni-online.de/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PATCHES="${FILESDIR}/${P}"-gcc34.patch

src_unpack() {
	kde_src_unpack
	rm "${S}"/quintalign/doc/quintalign/dtd/kdex.dtd
}
