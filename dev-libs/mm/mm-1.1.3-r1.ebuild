# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.1.3-r1.ebuild,v 1.1 2002/05/04 01:47:46 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.engelschall.com/sw/mm/"
SRC_URI="http://www.engelschall.com/sw/mm/${P}.tar.gz"
DEPEND="virtual/glibc"
LICENSE="as-is"
SLOT="1"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/mm-1.1.3-shtool.patch || die
}

src_compile() {
	libtoolize --force
	econf --host=${CHOST} || die "bad ./configure"
	make || die "compile problem"
	make test || die "testing problem"
}

src_install() {
	einstall || die
	dodoc README LICENSE ChangeLog INSTALL PORTING THANKS
}
