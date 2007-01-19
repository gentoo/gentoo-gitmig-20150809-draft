# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pl/ispell-pl-20021127.ebuild,v 1.10 2007/01/19 13:53:38 masterdriverz Exp $

DESCRIPTION="Polish dictionary for ispell"
SRC_URI="mirror://sourceforge/ispell-pl/${P}.tar.gz"
HOMEPAGE="http://ispell-pl.sourceforge.net/"

IUSE=""
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="app-text/ispell"

DICTBUILD="./zbuduj.slownik.sh"

src_compile() {
	# update the script to be POSIX-compatible
	sed "s/sort +1/sort -k 1/" $DICTBUILD > $DICTBUILD.tmp
	cp $DICTBUILD.tmp $DICTBUILD
	$DICTBUILD
}

src_install () {
	insinto /usr/lib/ispell
	doins polish.aff polish.hash
	dodoc Changelog CZYTAJ.TO
}
