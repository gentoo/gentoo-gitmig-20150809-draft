# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intel2gas/intel2gas-1.3.3.ebuild,v 1.3 2004/06/25 02:36:40 agriffis Exp $

DESCRIPTION="Converts assembler source from Intel (NASM), to AT&T (gas)"
HOMEPAGE="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/"
SRC_URI="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
	sys-devel/gcc"
RDEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix=${D}/usr \
		install || die
	dodoc README DATAFILES BUGS
}
