# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.3.ebuild,v 1.1 2004/05/08 01:06:47 dragonheart Exp $

inherit flag-o-matic libtool eutils

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
SRC_URI="mirror://gnu/gmp/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ia64"
IUSE="debug"

DEPEND="~sys-devel/m4-1.4
	sys-apps/gawk
	sys-devel/bison
	sys-devel/flex
	sys-devel/libtool
	sys-devel/gcc
	virtual/glibc"

RDEPEND="virtual/glibc"

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

	# It's pretty slow to run all the checks, and not really necessary
	# on every build of this package.  Just run the checks when
	# debugging is enabled.  (23 Feb 2003 agriffis)
	if use debug ; then
		make check || die "make check failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}
