# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tom Bevan tom@regex.com.au
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2000.12.ebuild,v 1.2 2002/04/27 10:22:26 seemant Exp $

MY_P="hugs98-Dec2001"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}/src/unix || die
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	cd ..
	emake || die
}

src_install () {
	cd ${S}/src || die
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc Credits License Readme Install
}
