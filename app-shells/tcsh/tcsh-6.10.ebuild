# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.10.ebuild,v 1.1 2000/11/26 20:54:17 achim Exp $
      
A=${P}.tar.gz
S=${WORKDIR}/${P}.00
DESCRIPTION="The standard GNU Bourne again shell"
#ugh, astron.com doesn't support passive ftp... maybe another source?
SRC_URI="ftp://ftp.astron.com/pub/tcsh/"${A}
DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"

src_compile() {                           
	cd ${S}
	try ./configure --prefix=/ --mandir=/usr/man --host=${CHOST}
	try make
}

src_install() {                               
	cd ${S}
	try make DESTDIR=${D} install install.man
	try perl tcsh.man2html
	dosym tcsh /bin/csh
	dodoc FAQ Fixes NewThings Ported README WishList Y2K
	docinto html
	dodoc tcsh.html/*.html
}



