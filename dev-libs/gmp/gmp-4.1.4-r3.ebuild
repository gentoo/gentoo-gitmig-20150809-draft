# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.4-r3.ebuild,v 1.12 2006/04/07 09:45:50 gmsoft Exp $

inherit flag-o-matic eutils libtool

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.swox.com/gmp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	doc? ( http://www.swox.se/${PN}/${PN}-man-${PV}.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc nocxx"

RDEPEND=""
DEPEND=""

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}/*.diff
	epatch "${FILESDIR}"/${P}-noexecstack.patch
	use ppc64 && epatch "${FILESDIR}"/${P}-asm-dots.patch
	epatch "${FILESDIR}"/${P}-ABI-multilib.patch
	epatch "${FILESDIR}"/${PN}-hppa-2.0.patch

	# note: we cannot run autotools here as gcc depends on this package
	elibtoolize
}

src_compile() {
	filter-flags -ffast-math


	# GMP beleives hppa2.0 is 64bit
	if [[ ${CHOST} == hppa2.0-* ]] ; then
		is_hppa_2_0=1
		export CHOST="${CHOST/2.0/1.1}"
	fi

	# FreeBSD libc already have bsdmp
	econf \
		--localstatedir=/var/state/gmp \
		--disable-mpfr \
		$(use_enable !nocxx cxx) \
		$(use_enable !elibc_FreeBSD mpbsd) \
		|| die "configure failed"

	# Fix the ABI for hppa2.0
	if [ ! -z "${is_hppa_2_0}" ]; then
		sed -i "${S}/config.h" -e 's:pa32/hppa1_1:pa32/hppa2_0:'
		export CHOST="${CHOST/1.1/2.0}"
	fi


	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc

	use doc && cp "${DISTDIR}"/gmp-man-${PV}.pdf "${D}"/usr/share/doc/${PF}/
}
