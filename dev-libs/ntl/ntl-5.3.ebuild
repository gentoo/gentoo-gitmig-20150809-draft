# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ntl/ntl-5.3.ebuild,v 1.3 2003/02/13 10:48:25 vapier Exp $

IUSE=""

DESCRIPTION="high-performance, portable C++ ci-computational ibrar"
HOMEPAGE="http://shoup.net/ntl/"
SRC_URI="http://www.shoup.net/ntl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=gmp-4.1-r1"

S="${WORKDIR}/${P}"

src_compile() {
	cd src
	./configure \
		PREFIX=/usr \
		NTL_GMP_LIP=on \
		"CFLAGS=$CFLAGS -Wno-deprecated" || die "./configure failed"

	make || die "make failed"
	make check || die "make check failed - make did not make something good..."
}

src_install() {
	cd src
	make PREFIX=${D}/usr/ install || die

	#now somewhat clean-up docs
	cd ${S}
	dodoc README
	cd ${S}/doc
	dodoc *.txt
	dohtml *.html *.gif

	rm -rf ${D}/usr/doc
}
