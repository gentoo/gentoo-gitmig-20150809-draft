# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparc32/sparc32-1.1.ebuild,v 1.6 2004/02/23 00:23:17 agriffis Exp $

DESCRIPTION="A SPARC32 compilation environment."
LICENSE="GPL-2"
SRC_URI="ftp://ftp.auxio.org/pub/linux/SOURCES/${P}.tgz"
SLOT="0"

KEYWORDS="sparc -x86 -ppc"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	patch -p0 -i ${FILESDIR}/sparc32-1.1-include.patch
	patch -p0 -i ${FILESDIR}/sparc32-1.1-fhs.patch
}

src_compile() {
	emake || die
}

src_install () {
	make prefix=${D} install
}
