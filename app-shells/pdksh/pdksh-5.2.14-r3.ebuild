# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r3.ebuild,v 1.4 2002/07/25 15:39:00 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Public Domain Korn Shell"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/${P}.tar.gz
	 ftp://ftp.cs.mun.ca/pub/pdksh/${P}-patches.1"
HOMEPAGE="http://ww.cs.mun.ca/~michael/pdksh/"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  patch -p2 < ${DISTDIR}/${P}-patches.1
}
 
src_compile() {

	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {

	into /
	dobin ksh
	into /usr
	doman ksh.1
	dodoc BUG-REPORTS ChangeLog* CONTRIBUTORS LEGAL NEWS NOTES PROJECTS README
	docinto etc
	dodoc etc/*
}






