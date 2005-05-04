# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20020216.ebuild,v 1.14 2005/05/04 17:59:23 dholm Exp $

S=${WORKDIR}
DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/mmix.tar.gz"
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"

DEPEND="virtual/libc
	>=dev-util/cweb-3.63
	virtual/ghostscript"

SLOT="0"
LICENSE="mmix"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

src_compile() {
	make basic CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin mmix mmixal
	dodoc README mmix.1
}
