# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/fnord/fnord-1.2.ebuild,v 1.3 2005/03/03 18:48:54 ciaranm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yet another small httpd."
SRC_URI="http://www.fefe.de/fnord/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/fnord/"
KEYWORDS="x86 sparc"
SLOT="0"
IUSE=""
LICENSE="GPL-2"

DEPEND="dev-libs/dietlibc"

RDEPEND="sys-process/daemontools"

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
