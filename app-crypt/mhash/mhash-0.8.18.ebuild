# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.8.18.ebuild,v 1.1 2003/04/24 17:10:49 robbat2 Exp $

DESCRIPTION="mhash is a library providing a uniform interface to a large number of hash algorithms."
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"
HOMEPAGE="http://mhash.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha hppa"

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	econf
	emake || die
}

src_install() {
	dodir /usr/{bin,include,lib}

	einstall

	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	dodoc doc/*.txt doc/skid*
	dohtml -r doc
}
