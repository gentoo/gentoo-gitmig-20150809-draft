# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header:#

S=${WORKDIR}/${P}
DESCRIPTION="File history and comparison tools"
SRC_URI="http://www.canb.auug.org.au/~millerp/${P}.tar.gz"
HOMEPAGE="http://www.canb.auug.org.au/~millerp/fhist.html"

DEPEND="sys-devel/gettext sys-apps/groff sys-devel/bison"
RDEPEND=""

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	make clean 
	make || die
}

src_install () {
	make RPM_BUILD_ROOT=${D} install || die
	
	dodoc lib/en/*.txt
	dodoc lib/en/*.ps
	
	# remove duplicate docs etc.
	rm -r ${D}/usr/share/fhist
	
	# move message catalogs into the usual gentoo place 
	mkdir ${D}/usr/share/locale
	mv ${D}/usr/lib/fhist/en ${D}/usr/share/locale/
}
