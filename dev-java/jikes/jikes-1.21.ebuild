# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.21.ebuild,v 1.7 2005/05/14 19:36:53 mholzer Exp $

inherit flag-o-matic

DESCRIPTION="IBM's open source, high performance Java compiler"
HOMEPAGE="http://jikes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="IBM"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 alpha ia64 hppa"
IUSE=""
DEPEND="virtual/libc"
DEPEND=""

src_compile() {
	filter-flags "-fno-rtti"
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
