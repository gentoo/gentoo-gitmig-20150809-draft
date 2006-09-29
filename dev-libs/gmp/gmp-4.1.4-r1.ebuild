# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.4-r1.ebuild,v 1.9 2006/09/29 21:31:38 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	doc? ( http://www.swox.se/${PN}/${PN}-man-${PV}.pdf )"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="sys-devel/libtool"

src_unpack () {
	unpack ${A}
	cd "${S}"

	# This patch will actually be somewhat short lived as it's really
	# somewhat of a hack. The toolchain folks (alanm) have a set of patches
	# to remove the use of the '.' form in ppc64 assembler
	if use ppc64 ; then
		epatch "${FILESDIR}"/ppc64-gmp-acinclude.patch
	fi

	# fix problems for -O3 or higher; bug #66780
	if use amd64; then
		epatch "${FILESDIR}"/amd64.patch
	fi

	epatch "${FILESDIR}"/${PN}-4.1.4-multilib.patch

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
	libtoolize --copy --force || die "libtoolize --copy --force failed"
	autoreconf || die "autoconf failed"
}

src_compile() {
	local myconf=""
	use sparc || myconf="--enable-mpfr"

	# We need to force 1.0 ABI as 2.0w doesn't work with GNU AS
	use hppa && export GMPABI="1.0"


	# FreeBSD libc already have bsdmp
	econf \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		$(use_enable !elibc_FreeBSD mpbsd) \
		${myconf} \
		|| die "configure failed"
	emake || die "emake failed"

}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc

	use doc && cp ${DISTDIR}/gmp-man-${PV}.pdf ${D}/usr/share/doc/${PF}
}
