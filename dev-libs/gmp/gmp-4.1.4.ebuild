# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.4.ebuild,v 1.2 2004/11/01 19:50:46 pylon Exp $

inherit flag-o-matic libtool eutils

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
SRC_URI="mirror://gnu/gmp/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~alpha arm hppa ~amd64 ia64 s390 ppc64"
IUSE="debug"

DEPEND="sys-apps/gawk
	sys-devel/bison
	sys-devel/flex
	sys-devel/libtool
	sys-devel/gcc
	virtual/libc"

RDEPEND="virtual/libc"

src_unpack () {
	unpack ${A}
	cd ${S}

#   This patch will actually be somewhat short lived as it's really
#   somewhat of a hack. The toolchain folks (alanm) have a set of patches
#   to remove the use of the '.' form in ppc64 assembler
	use ppc64 && epatch ${FILESDIR}/ppc64-gmp-acinclude.patch

	autoreconf
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
		${myconf} \
		|| die "configure failed"
	emake || die "emake failed"

}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

src_test() {


	# It's pretty slow to run all the checks, and not really necessary
	# on every build of this package.  Just run the checks when
	# debugging is enabled.  (23 Feb 2003 agriffis)
	if use debug ; then
		emake check || die "make check failed"
	else
	# Quick partial test
		make -C tests/cxx/ check-TESTS
	fi

}
