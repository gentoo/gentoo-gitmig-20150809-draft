# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.16.ebuild,v 1.7 2003/12/29 03:54:53 kumba Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Prints out location of specified executables that are in your path"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
SRC_URI="http://www.xs4all.nl/~carlo17/which/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha mips hppa ~arm ia64 ppc64"

RDEPEND="virtual/glibc
	sys-apps/texinfo"

DEPEND="${RDEPEND}"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/which-gentoo.patch
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
