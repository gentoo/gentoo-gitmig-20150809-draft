# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-autoresponder/qmail-autoresponder-0.96.2.ebuild,v 1.1 2006/02/20 21:22:05 hansmi Exp $

inherit fixheadtails eutils toolchain-funcs

DESCRIPTION="Rate-limited autoresponder for qmail."
SRC_URI="http://untroubled.org/qmail-autoresponder/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-autoresponder/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="mysql"

DEPEND="virtual/libc
		dev-libs/bglibs
		mysql? ( dev-db/mysql )"
RDEPEND="
	${DEPEND}
	virtual/qmail
	mysql? ( dev-db/mysql )
"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file Makefile
}

src_compile() {
	cd ${S}
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld

	# fails on parallel builds!
	make qmail-autoresponder || die "Failed to make qmail-autoresponder"
	if use mysql; then
		make qmail-autoresponder-mysql || die "Failed to make qmail-autoresponder-mysql"
	fi
}

src_install () {
	dobin qmail-autoresponder
	doman qmail-autoresponder.1
	if use mysql; then
		dobin qmail-autoresponder-mysql
		dodoc schema.mysql
	fi

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION COPYING ChangeLog procedure.txt
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README.gz for per-user configurations"
}
