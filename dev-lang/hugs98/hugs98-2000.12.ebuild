# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tom Bevan tom@regex.com.au
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2000.12.ebuild,v 1.1 2002/04/24 19:45:33 karltk Exp $

P="hugs98-Dec2001"
S=${WORKDIR}/${P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/hugs98-Dec2001.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

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

