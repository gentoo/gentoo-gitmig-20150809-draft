# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/geresh/geresh-0.4.1.ebuild,v 1.4 2004/03/13 22:30:15 mr_bones_ Exp $

DESCRIPTION="A simple multi-lingual console text editor with bidi & utf support"
HOMEPAGE="http://www.typo.co.il/~mooffie/geresh/"
SRC_URI="http://www.typo.co.il/~mooffie/geresh/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="spell nls"

DEPEND="dev-libs/fribidi
	sys-libs/ncurses
	spell?	( nls? ( >=app-text/hspell-0.5 ) )
	spell?  ( virtual/aspell-dict )"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
