# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intel2gas/intel2gas-1.3.3.ebuild,v 1.1 2004/03/22 09:09:01 dragonheart Exp $

DESCRIPTION="Converts assembler source from Intel (NASM), to AT&T (gas)"
HOMEPAGE="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/"
SRC_URI="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
	sys-devel/gcc"
RDEPEND="virtual/glibc"
S=${WORKDIR}/${P}

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
