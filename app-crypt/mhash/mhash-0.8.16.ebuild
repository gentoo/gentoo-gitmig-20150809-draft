# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.8.16.ebuild,v 1.7 2002/10/04 03:57:58 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mhash is a library providing a uniform interface to a large number of hash algorithms."
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/mhash/${P}.tar.gz"
HOMEPAGE="http://mhash.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

RDEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install () {
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	dodoc doc/*.txt doc/skid*
	dohtml -r doc
}
