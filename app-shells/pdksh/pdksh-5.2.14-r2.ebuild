# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r2.ebuild,v 1.1 2000/11/26 20:54:17 achim Exp $

P=pdksh-5.2.14      
A="${P}.tar.gz ${P}-patches.1"
S=${WORKDIR}/${P}
DESCRIPTION="The Public Domain Korn Shell"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/${P}.tar.gz
	 ftp://ftp.cs.mun.ca/pub/pdksh/${P}-patches.1"
HOMEPAGE="http://ww.cs.mun.ca/~michael/pdksh/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  patch -p2 < ${DISTDIR}/${P}-patches.1
}
 
src_compile() {                           
	cd ${S}
	try ./configure --prefix=/usr --host=${CHOST}
	try make 
}

src_install() {                               
	cd ${S}
	into /
	dobin ksh
	into /usr
	doman ksh.1
	dodoc BUG-REPORTS ChangeLog* CONTRIBUTORS LEGAL NEWS NOTES PROJECTS README
	docinto etc
	dodoc etc/*
}






