# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.2.ebuild,v 1.1 2003/02/22 16:29:03 agriffis Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="mirror://gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="LGPL-2"

DEPEND=">=sys-devel/m4-1.4p"

src_compile() {                           
	local myconf=""
	use sparc || myconf="--enable-mpfr"

	econf \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		--enable-mpbsd \
		${myconf} || die "configure failed"

	emake || die "emake failed"
	make check || die "make check failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}
