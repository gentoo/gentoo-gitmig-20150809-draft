# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpio/cpio-2.4.2-r4.ebuild,v 1.8 2002/07/16 05:50:52 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="ftp://prep.ai.mit.edu/gnu/cpio/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2 LGPL-2"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv rmt.c rmt.c.orig
	sed -e "78d" rmt.c.orig > rmt.c
	mv userspec.c userspec.c.orig
	sed -e "85d" userspec.c.orig > userspec.c
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

