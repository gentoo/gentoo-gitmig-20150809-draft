# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ga/ispell-ga-3.3.ebuild,v 1.1 2003/09/09 10:43:16 seemant Exp $

IUSE=""

MY_P=ispell-gaeilge-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Irish dictionary for ispell"
HOMEPAGE="http://borel.slu.edu/ispell/"
SRC_URI="http://borel.slu.edu/ispell/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa mips"

DEPEND="app-text/ispell"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/ispell
	doins gaeilge.hash gaeilge.aff

	dodoc README COPYING
}
