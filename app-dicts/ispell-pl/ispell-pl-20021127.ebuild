# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pl/ispell-pl-20021127.ebuild,v 1.11 2008/11/03 18:29:41 pva Exp $

inherit multilib

DESCRIPTION="Polish dictionary for ispell"
HOMEPAGE="http://ispell-pl.sourceforge.net/"
SRC_URI="mirror://sourceforge/ispell-pl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"

DICTBUILD="./zbuduj.slownik.sh"

src_compile() {
	sed "s/sort +1/sort -k 1/" -i zbuduj.slownik.sh
	./zbuduj.slownik.sh || die
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins polish.aff polish.hash || die
	dodoc Changelog CZYTAJ.TO
}
