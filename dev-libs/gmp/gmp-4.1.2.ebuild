# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.2.ebuild,v 1.25 2004/09/23 04:46:04 vapier Exp $

inherit flag-o-matic libtool eutils

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
SRC_URI="mirror://gnu/gmp/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/bison
	sys-devel/flex
	sys-devel/libtool
	sys-devel/gcc
	virtual/libc"

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}; cd ${S}
	use amd64 && epatch ${FILESDIR}/longlong.patch
}

src_compile() {
	filter-flags -ffast-math

	elibtoolize

	local myconf=""
	use sparc || myconf="--enable-mpfr"
	use hppa && export CHOST="hppa-unknown-linux-gnu"

	econf \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		--enable-mpbsd \
		--disable-fft \
		${myconf} \
		|| die "configure failed"
	emake || die "emake failed"

}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

src_test() {

	# the total check is broken due to a deprecated header use
	# t-locale.cc:24:23: strstream.h: No such file or directory
	make -C tests/mpf check-TESTS

}
