# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.10-r1.ebuild,v 1.1 2001/04/13 13:45:25 achim Exp $
      
A=${P}.tar.gz
S=${WORKDIR}/${P}.00
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
#ugh, astron.com doesn't support passive ftp... maybe another source?
SRC_URI="ftp://ftp.astron.com/pub/tcsh/${A}"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
    perl? ( sys-devel/perl )"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-tc.os.h-gentoo.diff
}

src_compile() {

	try ./configure --prefix=/ --mandir=/usr/share/man --host=${CHOST}
	try make
}

src_install() {

	try make DESTDIR=${D} install install.man
    if [ "`use perl`" ]
    then
	  try perl tcsh.man2html
      docinto html
	  dodoc tcsh.html/*.html
    fi
	dosym tcsh /bin/csh
	dodoc FAQ Fixes NewThings Ported README WishList Y2K

}



