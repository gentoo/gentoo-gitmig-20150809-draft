# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.12-r2.ebuild,v 1.14 2003/06/21 21:19:41 drobbins Exp $

DESCRIPTION="Prints out location of specified executables that are in your path"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
SRC_URI="http://www.xs4all.nl/~carlo17/which/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc "

RDEPEND="virtual/glibc
	sys-apps/texinfo"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 -i ${FILESDIR}/which-gentoo.patch || die
}

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install() {
	dobin which
	doman which.1
	doinfo which.info
	dodoc AUTHORS COPYING EXAMPLES NEWS README*
}
