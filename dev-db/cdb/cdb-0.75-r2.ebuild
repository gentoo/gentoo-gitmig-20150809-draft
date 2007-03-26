# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/cdb/cdb-0.75-r2.ebuild,v 1.2 2007/03/26 07:48:10 antarus Exp $

inherit eutils toolchain-funcs

DESCRIPTION="fast, reliable, simple package for creating and reading constant databases"
HOMEPAGE="http://cr.yp.to/cdb.html"
SRC_URI="http://cr.yp.to/cdb/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-apps/sed-4
	!dev-db/freecdb"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-errno.diff

	sed -i \
		-e 's/head -1/head -n 1/g' Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"
}

src_install() {
	dobin cdbdump cdbget cdbmake cdbmake-12 cdbmake-sv cdbstats cdbtest || \
		die "dobin failed"

	# ok so.. first off, some automakes fail at not finding
	# cdb.a, so install that
	dolib *.a || die

	# then do this pretty little symlinking to solve the somewhat
	# cosmetic library issue at hand
	dosym cdb.a /usr/$(get_libdir)/libcdb.a || die "newlib.a failed"

	# uint32.h needs installation too, otherwise compiles depending
	# on it will fail
	insinto /usr/include
	doins cdb*.h buffer.h alloc.h uint32.h || die "doins failed"

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
