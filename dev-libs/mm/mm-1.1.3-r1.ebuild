# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.1.3-r1.ebuild,v 1.3 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.engelschall.com/sw/mm/"
SRC_URI="http://www.engelschall.com/sw/mm/${P}.tar.gz"

SLOT="1"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

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
