# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.19.ebuild,v 1.3 2004/03/22 04:37:30 zx Exp $

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"
SRC_URI="ftp://www-126.ibm.com/pub/jikes/${PV}/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 alpha ia64 ~hppa"

DEPEND="virtual/glibc"
DEPEND=""

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
