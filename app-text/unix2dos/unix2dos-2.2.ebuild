# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unix2dos/unix2dos-2.2.ebuild,v 1.6 2004/01/20 20:24:24 avenj Exp $

DESCRIPTION="unix2dos - UNIX to DOS text file format converter"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.src.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc alpha ~amd64"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	patch -p1 < ${FILESDIR}/${PN}-mkstemp.patch || die
	patch -p1 < ${FILESDIR}/${P}-segfault.patch || die
	patch -p1 < ${FILESDIR}/${P}-manpage.patch || die
}

src_compile() {
	gcc ${CFLAGS} -o unix2dos unix2dos.c || die
}

src_install() {
	dobin unix2dos
	doman unix2dos.1
}
