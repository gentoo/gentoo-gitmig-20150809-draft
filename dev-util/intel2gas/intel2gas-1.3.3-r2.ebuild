# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intel2gas/intel2gas-1.3.3-r2.ebuild,v 1.1 2005/09/29 21:51:51 dragonheart Exp $

inherit eutils

DESCRIPTION="Converts assembler source from Intel (NASM), to AT&T (gas)"
HOMEPAGE="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/"
SRC_URI="http://www.niksula.cs.hut.fi/~mtiihone/intel2gas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc
	sys-devel/gcc"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-segfault.patch
}

src_install() {
	emake \
		prefix=${D}/usr \
		install || die
	fperms ugo+r /usr/share/intel2gas/i2g/main.syntax
	dodoc README DATAFILES BUGS
}
