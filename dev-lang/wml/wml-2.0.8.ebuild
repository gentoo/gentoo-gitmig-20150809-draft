# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.8.ebuild,v 1.2 2002/08/14 11:58:50 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Website META Language"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"
HOMEPAGE="http://www.engelschall.com/sw/wml/"

DEPEND=">=perl-5.6.1-r3"
RDEPEND="${DEPEND}"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
