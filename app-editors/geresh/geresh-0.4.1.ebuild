# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/geresh/geresh-0.4.1.ebuild,v 1.6 2004/11/22 05:03:50 vapier Exp $

DESCRIPTION="A simple multi-lingual console text editor with bidi & utf support"
HOMEPAGE="http://www.typo.co.il/~mooffie/geresh/"
SRC_URI="http://www.typo.co.il/~mooffie/geresh/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="spell nls"

DEPEND="dev-libs/fribidi
	sys-libs/ncurses
	spell? (
		nls? ( >=app-text/hspell-0.5 )
		virtual/aspell-dict
	)"

src_install() {
	make install DESTDIR="${D}" || die
}
