# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.4-r2.ebuild,v 1.2 2005/12/27 22:40:43 dragonheart Exp $

inherit flag-o-matic eutils

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.swox.com/gmp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	doc? ( http://www.swox.se/${PN}/${PN}-man-${PV}.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="doc nocxx"

RDEPEND=""
DEPEND="sys-devel/libtool"

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-nostackexec.patch
	cd "${S}"

	# This patch will actually be somewhat short lived as it's really
	# somewhat of a hack. The toolchain folks (alanm) have a set of patches
	# to remove the use of the '.' form in ppc64 assembler
	if use ppc64 ; then
		epatch "${FILESDIR}"/ppc64-gmp-acinclude.patch
	fi

	epatch "${FILESDIR}"/${PV}/*.diff
	epatch "${FILESDIR}"/${PN}-4.1.4-multilib.patch
	epatch "${FILESDIR}"/${PN}-hppa-2.0.patch

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
	libtoolize --copy --force || die "libtoolize --copy --force failed"
	autoreconf || die "autoconf failed"
}

src_compile() {
	filter-flags -ffast-math

	# We need to force 1.0 ABI as 2.0w requires 64bit userland
	use hppa && export GMPABI="1.0"

	# FreeBSD libc already have bsdmp
	econf \
		--localstatedir=/var/state/gmp \
		--disable-mpfr \
		$(use_enable !nocxx cxx) \
		$(use_enable !elibc_FreeBSD mpbsd) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc

	use doc && cp "${DISTDIR}"/gmp-man-${PV}.pdf "${D}"/usr/share/doc/${PF}/
}
