# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.4.ebuild,v 1.13 2005/02/16 18:20:51 eradicator Exp $

inherit flag-o-matic libtool eutils multilib

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="mirror://gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="debug"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-devel/bison
	sys-devel/flex
	sys-devel/libtool
	sys-devel/gcc"

src_unpack () {
	unpack ${A}
	cd ${S}

	# This patch will actually be somewhat short lived as it's really
	# somewhat of a hack. The toolchain folks (alanm) have a set of patches
	# to remove the use of the '.' form in ppc64 assembler
	if use ppc64 ; then
		epatch ${FILESDIR}/ppc64-gmp-acinclude.patch
	fi

	# fix problems for -O3 or higher; bug #66780
	if use amd64; then
		epatch ${FILESDIR}/amd64.patch
	fi

	epatch ${FILESDIR}/${PN}-4.1.4-multilib.patch

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
	libtoolize --copy --force || die "libtoolize --copy --force failed"
	autoreconf || die "autoconf failed"
}

src_compile() {
	filter-flags -ffast-math

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
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

src_test() {
	make check || die "make check failed"
}
