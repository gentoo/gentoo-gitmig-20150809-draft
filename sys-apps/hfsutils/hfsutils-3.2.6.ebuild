# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $

S=${WORKDIR}/${P}
DESCRIPTION="HFS FS Access utils"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
KEYWORDS="ppc -x86 -sparc -sparc64"
DEPEND="virtual/glibc"
RDEPEND=""
SLOT="0"
LICENSE="0"

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
		
}
