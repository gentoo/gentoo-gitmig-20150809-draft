# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.4.2-r4.ebuild,v 1.6 2004/09/28 02:48:56 vapier Exp $

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
SRC_URI="ftp://prep.ai.mit.edu/gnu/cpio/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "78d" rmt.c
	sed -i "85d" userspec.c
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die
	emake || die
}

src_install() {
	#our official mt is now the mt in app-arch/mt-st (supports Linux 2.4, unlike this one)
	doman cpio.1
	doinfo cpio.info
	dodoc ChangeLog NEWS README
	into /
	dobin cpio || die
}
