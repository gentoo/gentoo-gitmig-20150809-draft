# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.6.7.ebuild,v 1.3 2006/09/29 20:51:35 wormo Exp $

DESCRIPTION="a morse tutor"
HOMEPAGE="http://savannah.nongnu.org/projects/aldo"
SRC_URI="http://savannah.nongnu.org/download/aldo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/ncurses"

src_compile() {
	# Fix Makefile to use ncurses instead of termcap (bug #103105)
	sed -i -e 's~termcap~ncurses~' Makefile
	make libs || die
	make aldo || die
}

src_install() {
	dobin aldo || die
	dodoc README* TODO VERSION AUTHORS ChangeLog
}

