# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-da/ispell-da-1.4.27.ebuild,v 1.2 2004/02/22 18:24:35 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A danish dictionary for ispell"
HOMEPAGE="http://da.speling.org/"
SRC_URI="http://da.speling.org/filer/${P}.tar.gz"

DEPEND="app-text/ispell"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 sparc alpha mips hppa"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/ispell
	doins dansk.aff dansk.hash

	dodoc COPYING Copyright README contributors
}
