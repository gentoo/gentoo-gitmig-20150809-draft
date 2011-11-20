# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.33_pre20100626.ebuild,v 1.3 2011/11/20 09:20:49 xarthisius Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~sparc ~x86"
IUSE="debug"

DEPEND=""
RDEPEND=""

DIETHOME=/usr/diet

pkg_setup() {
	# Replace sparc64 related C[XX]FLAGS (see bug #45716)
	use sparc && replace-sparc64-flags

	# gcc-hppa suffers support for SSP, compilation will fail
	use hppa && strip-unsupported-flags

	# debug flags
	use debug && append-flags -g

	# Makefile does not append CFLAGS
	append-flags -nostdinc -W -Wall -Wextra -Wchar-subscripts \
		-Wmissing-prototypes -Wmissing-declarations -Wno-switch \
		-Wno-unused -Wredundant-decls

	# only use -nopie on archs that support it
	gcc-specs-pie && append-flags -nopie
}

src_compile() {
	emake prefix=${DIETHOME} CC="$(tc-getCC)" CFLAGS="${CFLAGS}" -j1 || die "make failed"
}

src_install() {
	emake prefix=${DIETHOME} DESTDIR="${D}" -j1 install || die "make install failed"
	dobin "${D}"${DIETHOME}/bin/* || die "dobin failed"
	doman "${D}"${DIETHOME}/man/*/* || die "doman failed"
	rm -r "${D}"${DIETHOME}/{man,bin}
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
