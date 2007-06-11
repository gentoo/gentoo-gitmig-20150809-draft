# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.31_pre20070611.ebuild,v 1.1 2007/06/11 12:13:01 hollow Exp $

inherit eutils flag-o-matic

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="http://people.linux-vserver.org/~hollow/dietlibc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND=""

pkg_setup() {
	# Replace sparc64 related C[XX]FLAGS (see bug #45716)
	use sparc && replace-sparc64-flags

	# gcc-hppa suffers support for SSP, compilation will fail
	use hppa && strip-unsupported-flags

	# debug flags
	use debug && append-flags -g
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	local prefix=/usr/diet
	emake prefix=${prefix} DESTDIR="${D}" install || die "make install failed"
	dobin "${D}"${prefix}/bin/* || die "dobin failed"
	doman "${D}"${prefix}/man/*/* || die "doman failed"
	rm -r "${D}"${prefix}/{man,bin}
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
