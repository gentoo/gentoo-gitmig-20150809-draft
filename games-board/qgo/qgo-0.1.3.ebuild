# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-0.1.3.ebuild,v 1.1 2004/03/04 00:04:58 vapier Exp $

inherit kde-functions
need-qt 3

DESCRIPTION="A c++/qt go client and sgf editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		's:Horizontal Spacing2:_HorizontalSpacing2:' \
		`find qgo/src -iname '*.ui' -type f` \
		|| die "fixing ui files failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog
}
