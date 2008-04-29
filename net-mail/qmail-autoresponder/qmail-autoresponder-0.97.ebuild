# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-autoresponder/qmail-autoresponder-0.97.ebuild,v 1.1 2008/04/29 06:24:03 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="Rate-limited autoresponder for qmail."
HOMEPAGE="http://untroubled.org/qmail-autoresponder/"
SRC_URI="http://untroubled.org/qmail-autoresponder/archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="mysql"

DEPEND="virtual/libc
		>=dev-libs/bglibs-1.022
		mysql? ( virtual/mysql )"
RDEPEND="
	${DEPEND}
	virtual/qmail
	mysql? ( virtual/mysql )
"

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

	dodoc ANNOUNCEMENT NEWS README TODO ChangeLog procedure.txt
}

pkg_postinst() {
	elog "Please see /usr/share/doc/${PF}/README.gz for per-user configurations"
}
