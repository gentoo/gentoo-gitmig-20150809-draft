# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/leave/leave-20041016.ebuild,v 1.2 2004/10/26 13:47:09 ka0ttic Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Command-line tool from FreeBSD that reminds you when its time to leave"
HOMEPAGE="http://www.freebsd.org/cgi/cvsweb.cgi/src/usr.bin/leave/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-fix-makefile.diff
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin leave
	doman leave.1
	dodoc ${FILESDIR}/README
}
