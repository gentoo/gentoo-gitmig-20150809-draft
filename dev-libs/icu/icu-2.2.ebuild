# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-2.2.ebuild,v 1.9 2005/01/21 03:42:42 agriffis Exp $

S=${WORKDIR}/${PN}/source
DESCRIPTION="IBM Internationalization Components for Unicode"
SRC_URI="http://oss.software.ibm.com/icu/download/${PV}/${P}.tgz"
HOMEPAGE="http://oss.software.ibm.com/icu/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"
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
