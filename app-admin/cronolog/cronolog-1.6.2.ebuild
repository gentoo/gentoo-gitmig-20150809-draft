# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cronolog/cronolog-1.6.2.ebuild,v 1.4 2003/06/29 15:24:07 aliz Exp $

DESCRIPTION="Cronolog apache logfile rotator"
HOMEPAGE="http://cronolog.org/"
SRC_URI="http://cronolog.org/download/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND} net-www/apache"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
