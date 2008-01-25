# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-autoresponder/qmail-autoresponder-0.96.1-r1.ebuild,v 1.17 2008/01/25 20:54:00 bangert Exp $

inherit fixheadtails eutils toolchain-funcs

DESCRIPTION="Rate-limited autoresponder for qmail."
SRC_URI="http://untroubled.org/qmail-autoresponder/archive/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-autoresponder/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 hppa mips ppc sparc x86"
IUSE="mysql"

DEPEND="virtual/libc
		>=dev-libs/bglibs-1.019-r1
		mysql? ( virtual/mysql )"
RDEPEND="
	${DEPEND}
	virtual/qmail
	mysql? ( virtual/mysql )
"

src_unpack() {
	unpack ${A}

	# This patch fixes a multi-line string issue with gcc-3.3
	# Closes Bug #30137
	epatch "${FILESDIR}/${P}-gcc33-multiline-string-fix.patch"

	cd "${S}"
	ht_fix_file Makefile
}

src_compile() {
	echo "/usr/include/bglibs" > conf-bgincs
	echo "/usr/lib/bglibs" > conf-bglibs
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld

	# fails on parallel builds!
	make qmail-autoresponder || die "Failed to make qmail-autoresponder"
	if use mysql; then
		make qmail-autoresponder-mysql || die "Failed to make qmail-autoresponder-mysql"
	fi
}

src_install () {
	dobin qmail-autoresponder || die
	doman qmail-autoresponder.1
	if use mysql; then
		dobin qmail-autoresponder-mysql || die
		dodoc schema.mysql
	fi

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION ChangeLog procedure.txt
}

pkg_postinst() {
	elog "Please see /usr/share/doc/${PF}/README.gz for per-user configurations"
}
