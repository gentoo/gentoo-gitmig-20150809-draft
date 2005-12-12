# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cvm/cvm-0.76.ebuild,v 1.1 2005/12/12 04:52:05 robbat2 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Credential Validation Modules by Bruce Guenter"
HOMEPAGE="http://untroubled.org/cvm/"
SRC_URI="${HOMEPAGE}archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="mysql postgres"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		>=dev-libs/bglibs-1.027
		mysql? ( dev-db/mysql )
		postgres? ( dev-db/postgresql )"
		
src_compile() {
	echo "/usr/include/bglibs" > conf-bgincs
	echo "/usr/lib/bglibs" > conf-bglibs
	echo "${D}/usr/include" > conf-include
	echo "${D}/usr/lib" > conf-lib
	echo "${D}/usr/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) -lcrypt" > conf-ld
	emake || die

	if use mysql; then
		make mysql || die "making mysql support failed"
	fi

	if use postgres; then
		make pgsql || die "making postgres support failed"
	fi
}

src_install() {
	einstall || die

	dodoc ANNOUNCEMENT COPYING NEWS NEWS.sql NEWS.vmailmgr README README.vchkpw
	dodoc README.vmailmgr TODO VERSION
	dohtml *.html
}
