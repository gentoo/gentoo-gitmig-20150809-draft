# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.2.ebuild,v 1.1 2002/04/26 06:49:28 agenkin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="http://ftp.cvshome.org/${P}/${P}.tar.gz"
HOMEPAGE="http://www.cvshome.org/"
DEPEND="virtual/glibc 
        >=sys-libs/ncurses-5.1 
        >=sys-libs/zlib-1.1.4"

src_compile() {                           
	./configure --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info
	assert
	make || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING 
	dodoc MINOR* NEWS PROJECTS README* TESTS TODO
	mv ${D}/usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
	insinto /usr/share/emacs/site-lisp
	doins cvs-format.el
}
