# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-da/ispell-da-1.4.42.ebuild,v 1.7 2004/11/07 09:23:09 kumba Exp $

DESCRIPTION="A danish dictionary for ispell"
HOMEPAGE="http://da.speling.org/"
SRC_URI="http://da.speling.org/filer/${P}.tar.gz"

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
	doins dansk.aff dansk.hash
	dodoc README contributors
}
