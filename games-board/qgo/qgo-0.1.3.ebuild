# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-0.1.3.ebuild,v 1.4 2004/06/25 03:13:19 agriffis Exp $

inherit kde-functions
need-qt 3

DESCRIPTION="A c++/qt go client and sgf editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:Horizontal Spacing2:_HorizontalSpacing2:' \
		`find qgo/src -iname '*.ui' -type f` \
		|| die "fixing ui files failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog
}
