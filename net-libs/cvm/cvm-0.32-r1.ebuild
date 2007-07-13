# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cvm/cvm-0.32-r1.ebuild,v 1.5 2007/07/13 07:18:13 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="Credential Validation Modules by Bruce Guenter"
HOMEPAGE="http://untroubled.org/cvm/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="mysql postgres"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		>=dev-libs/bglibs-1.019
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql )"

src_compile() {
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "${D}/usr" > conf-home
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC)" > conf-ld
	make || die

	if use mysql; then
		make mysql || die "making mysql support failed"
	fi

	if use postgres; then
		make pgsql || die "making postgres support failed"
	fi
}

src_install() {
	#the installer requires ${D}/usr to be present
	dodir /usr

	./installer || die

	dodoc ANNOUNCEMENT COPYING NEWS NEWS.sql NEWS.vmailmgr README README.vchkpw
	dodoc README.vmailmgr TODO VERSION
	dohtml *.html
}
