# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/dybase/dybase-0.19.ebuild,v 1.1 2004/06/08 06:01:04 raker Exp $

DESCRIPTION="DyBASE is very simple object oriented embedded database for languages with dynamic type checking."
HOMEPAGE="http://www.garret.ru/~knizhnik/dybase.html"
SRC_URI="http://www.garret.ru/~knizhnik/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="sys-libs/glibc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	cd ${S}/src
	make || die "make failed"
}

src_install() {
	dolib.a ${S}/lib/*.a
	dolib.so ${S}/lib/*.so

	insinto /usr/include
	doins ${S}/inc/*.h

	dodir /usr/share/doc/${P}
	cp -r ${S}/doc ${S}/php ${S}/python ${S}/rebol ${S}/ruby \
	${D}/usr/share/doc/${P}/
}

