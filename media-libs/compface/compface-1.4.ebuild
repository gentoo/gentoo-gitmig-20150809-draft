# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# $Header: /var/cvsroot/gentoo-x86/media-libs/compface/compface-1.4.ebuild,v 1.7 2002/08/14 13:08:09 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities and library to convert to/from X-Face format"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	make || die
}

src_install () {
	dodir /usr/share/man/man{1,3} /usr/{bin,include,lib}
	make \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc README ChangeLog
}
