# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2002.11-r1.ebuild,v 1.1 2003/04/24 11:51:48 kosmikus Exp $

IUSE=""

MY_P="hugs98-Nov2002"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/Nov2002/${MY_P}.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs"

SLOT="0"
KEYWORDS="x86 ~sparc"
LICENSE="as-is"

DEPEND="virtual/glibc"

src_compile() {
	local myc

	cd ${S}/src/unix || die
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-ffi \
		--enable-double-precision \
		${myc} || die "./configure failed"
	cd ..
	emake || die
}

src_install () {
	cd ${S}/src || die
	make \
		HUGSDIR=${D}/usr/lib/hugs \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	
	#somewhat clean-up installation of few docs
	cd ${S}
	dodoc Credits License Readme
	cd ${D}/usr/lib/hugs
	rm Credits License Readme
	mv demos/ docs/ ${D}/usr/share/doc/${PF}
}
