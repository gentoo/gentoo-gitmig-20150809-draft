# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20060324.ebuild,v 1.1 2006/04/20 17:06:38 carlo Exp $

S=${WORKDIR}

DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator."
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/${P}.tar.gz"

DEPEND="virtual/libc
	>=dev-util/cweb-3.63
	app-text/tetex"
RDEPEND="virtual/libc"

SLOT="0"
LICENSE="mmix"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="doc"

src_compile() {
	make all CFLAGS="${CFLAGS}" || die
	if use doc ; then
		make doc || die
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
