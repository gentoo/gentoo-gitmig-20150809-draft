# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-2.8.ebuild,v 1.10 2004/10/20 01:17:00 agriffis Exp $

S=${WORKDIR}/${PN}/source
DESCRIPTION="IBM Internationalization Components for Unicode"
SRC_URI="ftp://www-126.ibm.com/pub/icu/${PV}/${P}.tgz"
HOMEPAGE="http://oss.software.ibm.com/icu/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 alpha ~ppc s390 ~ia64"
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
