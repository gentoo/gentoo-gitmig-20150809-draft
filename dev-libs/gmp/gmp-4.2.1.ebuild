# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.2.1.ebuild,v 1.13 2006/10/18 12:08:15 uberlord Exp $

inherit flag-o-matic eutils libtool

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.swox.com/gmp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	doc? ( http://www.swox.se/${PN}/${PN}-man-${PV}.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc nocxx"

RDEPEND=""
DEPEND=""

src_unpack () {
	unpack ${A}
	cd "${S}"
	local p
	for p in x86-fat configure-ppc aix.m4-RW ia64-popcount ; do
		epatch "${FILESDIR}"/${PV}/${p}.diff
	done
	epatch "${FILESDIR}"/${PN}-4.1.4-noexecstack.patch
	epatch "${FILESDIR}"/${P}-ABI-multilib.patch

	# note: we cannot run autotools here as gcc depends on this package
	elibtoolize
}

src_compile() {
	# GMP believes hppa2.0 is 64bit
	if [[ ${CHOST} == hppa2.0-* ]] ; then
		is_hppa_2_0=1
		export CHOST="${CHOST/2.0/1.1}"
	fi

	econf \
		--localstatedir=/var/state/gmp \
		--disable-mpfr \
		--disable-mpbsd \
		$(use_enable !nocxx cxx) \
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
