# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2000.12.ebuild,v 1.4 2002/07/18 03:41:50 george Exp $

MY_P="hugs98-Dec2001"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

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
