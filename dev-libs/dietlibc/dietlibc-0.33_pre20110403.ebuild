# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.33_pre20110403.ebuild,v 1.2 2011/05/01 15:28:46 hwoarang Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

GITHUB_AUTHOR="hollow"
GITHUB_PROJECT="dietlibc"
GITHUB_COMMIT="4e86d5e"

DESCRIPTION="A libc optimized for small size"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="http://nodeload.github.com/${GITHUB_AUTHOR}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${GITHUB_AUTHOR}-${GITHUB_PROJECT}-${GITHUB_COMMIT}

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
		-Wno-unused -Wredundant-decls -fno-strict-aliasing

	# only use -nopie on archs that support it
	gcc-specs-pie && append-flags -nopie
}

src_compile() {
	emake prefix=${DIETHOME} \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		STRIP=":" \
		|| die "make failed"
}

src_install() {
	emake prefix=${DIETHOME} \
		DESTDIR="${D}" \
		install-bin \
		install-headers \
		|| die "make install failed"

	dobin "${D}"${DIETHOME}/bin/* || die "dobin failed"
	doman "${D}"${DIETHOME}/man/*/* || die "doman failed"
	rm -r "${D}"${DIETHOME}/{man,bin}

	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
