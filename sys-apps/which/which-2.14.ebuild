# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.14.ebuild,v 1.19 2004/07/15 02:47:32 agriffis Exp $

DESCRIPTION="Prints out location of specified executables that are in your path"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
SRC_URI="http://www.xs4all.nl/~carlo17/which/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa "
IUSE=""

RDEPEND="virtual/libc
	sys-apps/texinfo"

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
