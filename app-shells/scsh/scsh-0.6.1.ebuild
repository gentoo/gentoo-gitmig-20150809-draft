# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/scsh/scsh-0.6.1.ebuild,v 1.2 2002/07/11 06:30:18 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scsh is a Unix shell embedded in Scheme"
SRC_URI="ftp://ftp.scsh.net/pub/scsh/0.6/scsh-${PV}.tar.gz"
HOMEPAGE="http://www.scsh.net/"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/ --host=${CHOST} \
		--mandir=/usr/share/man \
		--libdir=/usr/lib \
		--includedir=/usr/include
	make || die
}

src_install() {
	make prefix=${D} \
		htmldir=${D}/usr/share/doc/${P}/html \
		incdir=${D}/usr/include \
		libdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		install || die

	dodoc COPYING INSTALL RELEASE


	# Scsh doesn't have a very consistent documentation
	# structure. It's possible to override the placement of the
	# HTML during make install, but not the other documentation in
	# TeX, DVI and PS formats.

	# Thus we let scsh install the documentation and then clean up
	# afterwards.

	mv ${D}/usr/lib/scsh/doc/* ${D}/usr/share/doc/${P}
	rmdir ${D}/usr/lib/scsh/doc
	find ${D}/usr/share/doc/${P} \( -name \*.ps -o \
		-name \*.txt -o \
		-name \*.dvi -o \
		-name \*.tex \) \
		-print | xargs gzip
}
