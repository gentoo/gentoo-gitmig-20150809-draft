# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/fnord/fnord-1.2.ebuild,v 1.9 2004/02/22 16:51:52 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yet another small httpd."
SRC_URI="http://www.fefe.de/fnord/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/fnord/"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-libs/dietlibc"

RDEPEND="sys-apps/daemontools"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS=-O.*:CFLAGS=${CFLAGS}:" \
		Makefile.orig > Makefile

	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe fnord-conf fnord fnord-cgi

	dodoc TODO README SPEED COPYING CHANGES
}
