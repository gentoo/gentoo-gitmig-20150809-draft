# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-unix/ucspi-unix-0.36.ebuild,v 1.8 2004/07/15 02:45:25 agriffis Exp $

inherit eutils

DESCRIPTION="A ucspi implementation for unix sockets."
SRC_URI="http://untroubled.org/ucspi-unix/${P}.tar.gz"

DEPEND=">=dev-libs/bglibs-1.009-r1"
HOMEPAGE="http://untroubled.org/ucspi-unix/"
KEYWORDS="x86 amd64 ~sparc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}

	# Fix for head syntax in Makefile
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo-head.patch
}

src_compile() {
	echo "gcc ${CFLAGS} -I/usr/lib/bglibs/include" > conf-cc
	echo "gcc -s -L/usr/lib/bglibs/lib" > conf-ld
	make || die  #don't use emake b/c of jobserver
}

src_install () {
	exeinto /usr/bin
	doexe unixserver unixclient unixcat
	doman unixserver.1 unixclient.1

	dodoc ANNOUNCEMENT ChangeLog NEWS PROTOCOL README TODO
}
