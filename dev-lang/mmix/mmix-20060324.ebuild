# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20060324.ebuild,v 1.4 2006/12/23 20:41:29 dertobi123 Exp $

S=${WORKDIR}

DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator."
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/${P}.tar.gz"

DEPEND=">=dev-util/cweb-3.63
	doc? ( virtual/tetex )"
RDEPEND=""

SLOT="0"
LICENSE="mmix"
KEYWORDS="ppc ~x86"
IUSE="doc"

src_compile() {
	emake -j1 all CFLAGS="${CFLAGS}" || die
	if use doc ; then
		emake doc || die
	fi
}

src_install () {
	dobin mmix mmixal mmmix mmotype abstime
	dodoc README mmix.1
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins *.ps
	fi
}
