# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r3.ebuild,v 1.6 2002/07/29 02:24:21 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Public Domain Korn Shell"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/${P}.tar.gz
	 ftp://ftp.cs.mun.ca/pub/pdksh/${P}-patches.1"
HOMEPAGE="http://ww.cs.mun.ca/~michael/pdksh/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="as-is"

DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p2 < ${DISTDIR}/${P}-patches.1
}
 
src_compile() {

	./configure --prefix=/usr --host=${CHOST} || die
	make || die
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






