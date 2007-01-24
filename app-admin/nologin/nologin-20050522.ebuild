# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/nologin/nologin-20050522.ebuild,v 1.9 2007/01/24 14:43:41 genone Exp $

inherit toolchain-funcs

DESCRIPTION="OpenBSD's nologin - politely refuse a login; intended as a replacement shell field (in /etc/passwd) for accounts that have been disabled."
HOMEPAGE="http://www.openbsd.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86"
IUSE=""

RDEPEND="!sys-apps/shadow"

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} nologin.c -o nologin"
	$(tc-getCC) ${CFLAGS} nologin.c -o nologin || die "compilation failed"
}

src_install() {
	doman nologin.8 || die "doman failed"
	into /
	dosbin nologin || die "dosbin failed"
}

pkg_postinst() {
	elog
	elog "To use nologin, edit /etc/passwd and replace /bin/false with"
	elog "/sbin/nologin for those accounts."
	elog
	elog "If the file /etc/nologin.txt exists, nologin displays it's"
	elog "contents instead of the default message."
	elog
}
