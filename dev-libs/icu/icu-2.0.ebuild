# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-2.0.ebuild,v 1.3 2002/07/11 06:30:20 drobbins Exp $

S=${WORKDIR}/${PN}/source
DESCRIPTION="IBM Internationalization Components for Unicode"
SRC_URI="http://oss.software.ibm.com/icu/download/${PV}/${P}.tgz"
HOMEPAGE="http://oss.software.ibm.com/icu/index.html"

DEPEND=""
RDEPEND=""

src_compile() {
	./configure \
		--build=${CHOST} \
		--enable-layout \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dohtml ../readme.html ../license.html
}
