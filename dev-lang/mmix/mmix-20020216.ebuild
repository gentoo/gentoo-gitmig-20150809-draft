# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20020216.ebuild,v 1.3 2002/07/23 03:41:19 george Exp $

S=${WORKDIR}
DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/mmix.tar.gz"
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"

DEPEND="virtual/glibc
	>=dev-util/cweb-3.63"
RDEPEND="$DEPEND"

SLOT="0"
LICENSE="mmix"
KEYWORDS="x86"

src_compile() {
	make basic CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin mmix mmixal
	doman mmix.1
	dodoc README
}
