# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.16.ebuild,v 1.3 2002/09/20 20:55:40 vapier Exp $

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"
SRC_URI="ftp://www-126.ibm.com/pub/jikes/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
	|| die "configure problem"
	emake || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING AUTHORS README TODO NEWS
	mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/doc
}
