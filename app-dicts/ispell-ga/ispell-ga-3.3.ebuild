# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ga/ispell-ga-3.3.ebuild,v 1.4 2004/06/24 21:42:35 agriffis Exp $

MY_P=ispell-gaeilge-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Irish dictionary for ispell"
HOMEPAGE="http://borel.slu.edu/ispell/"
SRC_URI="http://borel.slu.edu/ispell/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa"
IUSE=""

DEPEND="app-text/ispell"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/ispell
	doins gaeilge.hash gaeilge.aff
	dodoc README
}
