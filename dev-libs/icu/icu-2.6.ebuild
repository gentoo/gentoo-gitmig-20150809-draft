# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-2.6.ebuild,v 1.10 2005/02/26 23:09:38 latexer Exp $

S=${WORKDIR}/${PN}/source
DESCRIPTION="IBM Internationalization Components for Unicode"
SRC_URI="ftp://www-126.ibm.com/pub/icu/${PV}/${P}.tgz"
HOMEPAGE="http://ibm.com/software/globalization/icu/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc ~alpha ~ia64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf --enable-layout || die
	make || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dohtml ../readme.html ../license.html
}
