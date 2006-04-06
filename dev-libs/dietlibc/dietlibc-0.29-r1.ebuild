# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.29-r1.ebuild,v 1.2 2006/04/06 18:54:00 phreak Exp $

inherit eutils flag-o-matic

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/dietlibc-patches-${PVR}.tar.bz2
	http://dev.gentoo.org/~hollow/distfiles/dietlibc-patches-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND=""

pkg_setup() {
	# We need to disable the -pie features, dietlibc won't build with pie
	# enabled.
	echo
	einfo "dev-libs/dietlibc is having some problems with PIE support."
	einfo "Therefore PIE is disabled for now!"
	echo
	append-flags -fno-pie

	# Replace sparc64 related C[XX]FLAGS (see bug #45716)
	use sparc && replace-sparc64-flags

	# gcc-hppa suffers support for SSP, compilation will fail
	use hppa && strip-unsupported-flags
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${PN}-patches/[0-1]*.patch
	use ppc && \
		epatch "${WORKDIR}"/${PN}-patches/20_ppc32-userland-on-64bit.patch
}

src_compile() {
	local make_opt=
	use debug && make_opt="DEBUG=1"
	emake CFLAGS="${CFLAGS}" ${make_opt} || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dobin "${D}"/usr/diet/bin/* || die "dobin failed"
	doman "${D}"/usr/diet/man/*/* || die "doman failed"
	rm -r "${D}"/usr/diet/{man,bin}
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING

	# Fixing a bug on ppc/ppc64, where diet is assuming the
	# libraries are located at /usr/diet/lib-powerpc instead of
	# /usr/diet/lib-ppc
	use ppc64 && dosym /usr/diet/lib-ppc64 /usr/diet/lib-powerpc64
	use ppc && dosym /usr/diet/lib-ppc /usr/diet/lib-powerpc
}
