# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt/ispell-pt-20041027.ebuild,v 1.4 2010/10/08 01:35:58 leio Exp $

S=${WORKDIR}"/portugues"
DESCRIPTION="A Portuguese dictionary for ispell"
SRC_URI="http://natura.di.uminho.pt/download/sources/Dictionaries/ispell/ispell.pt.${PV}.tar.gz"
HOMEPAGE="http://natura.di.uminho.pt"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

DEPEND="app-text/ispell"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins portugues.aff portugues.hash

	dodoc README
}
