# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.2.ebuild,v 1.3 2002/07/21 01:09:58 cardoe Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="http://ftp.cvshome.org/${P}/${P}.tar.gz"
HOMEPAGE="http://www.cvshome.org/"
DEPEND="virtual/glibc 
        >=sys-libs/ncurses-5.1 
        >=sys-libs/zlib-1.1.4"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2 LGPL-2"

src_compile() {                           
	./configure --prefix=/usr \
		    --mandir=/usr/share/man \
		    --infodir=/usr/share/info
	assert
	make || die
}

src_install() {                               
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     install || die

	dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING 
	dodoc MINOR* NEWS PROJECTS README* TESTS TODO
	mv ${D}/usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
	insinto /usr/share/emacs/site-lisp
	doins cvs-format.el
}
