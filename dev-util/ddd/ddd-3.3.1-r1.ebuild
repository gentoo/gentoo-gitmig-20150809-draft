# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ddd/ddd-3.3.1-r1.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU DDD is a graphical front-end for command-line debuggers"
SRC_URI="ftp://ftp.easynet.be/gnu/ddd/${P}.tar.gz \
	ftp://ftp.easynet.be/gnu/ddd/${P}-html-manual.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ddd"

DEPEND="virtual/glibc
	virtual/x11
	>=sys-devel/gdb-4.16
	>=x11-libs/openmotif-2.1.30"
	
src_compile() {
	try ./configure	--host=${CHOST} \
				--prefix=/usr \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info
	
	try emake
}

src_install () {
	try make DESTDIR=${D} install
	
	mv ${S}/doc/README ${S}/doc/README-DOC
	dodoc ANNOUNCE AUTHORS BUGS COPYING* CREDITS INSTALL NEWS* NICKNAMES \
		OPENBUGS PROBLEMS README* TIPS TODO doc/README-DOC
	
	rm ${S}/doc/README-DOC
	mv ${S}/doc/* ${D}/usr/share/doc/${PF}
}

