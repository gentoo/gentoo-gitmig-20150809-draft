# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-0.2.2.ebuild,v 1.3 2005/03/31 17:36:05 mr_bones_ Exp $

inherit kde-functions eutils
need-qt 3

DESCRIPTION="A c++/qt go client and sgf editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${P}-b3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gcc.patch"
	sed -i \
		-e 's:Horizontal Spacing2:_HorizontalSpacing2:' \
		`find qgo/src -iname '*.ui' -type f` \
		|| die "fixing ui files failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc qgo/README ChangeLog TODO
}
