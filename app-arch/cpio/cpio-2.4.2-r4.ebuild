# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.4.2-r4.ebuild,v 1.1 2003/11/15 01:34:06 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="ftp://prep.ai.mit.edu/gnu/cpio/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
KEYWORDS="x86 amd64 ppc sparc alpha hppa mips ia64"
SLOT="0"
LICENSE="GPL-2 LGPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "78d" rmt.c
	sed -i "85d" userspec.c
}

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr || die
	emake || die
}

src_install() {
	#our official mt is now the mt in app-arch/mt-st (supports Linux 2.4, unlike this one)
	dobin cpio
	doman cpio.1
	doinfo cpio.info
	dodoc COPYING* ChangeLog NEWS README
}

