# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/leave/leave-20041016.ebuild,v 1.7 2009/04/16 20:11:42 tcunha Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Command-line tool from FreeBSD that reminds you when its time to leave"
HOMEPAGE="http://www.freebsd.org/cgi/cvsweb.cgi/src/usr.bin/leave/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
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
	dobin leave || die "dobin failed"
	doman leave.1 || die "doman failed"
	dodoc ${FILESDIR}/README || die "dodoc failed"
}
