# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Charles Kerr <punt@kerrskorner.org>
# Maintainer: Chris Houser <chouser@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp

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
