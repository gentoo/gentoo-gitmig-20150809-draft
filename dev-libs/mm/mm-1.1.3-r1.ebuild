# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.1.3-r1.ebuild,v 1.9 2004/01/18 18:25:02 tuxus Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

SLOT="1"
LICENSE="as-is"
KEYWORDS="x86 sparc amd64 ~mips"

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
