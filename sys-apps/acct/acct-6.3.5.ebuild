# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acct/acct-6.3.5.ebuild,v 1.11 2004/09/03 21:03:23 pvdabeel Exp $

inherit eutils

MY_P=${P/-/_}
DESCRIPTION="GNU system accounting utilities"
HOMEPAGE="http://www.gnu.org/directory/acct.html"
SRC_URI="mirror://debian/pool/main/a/acct/${MY_P}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PF}-gentoo.diff"
}

src_install() {
	dobin ac last lastcomm || die "dobin failed"
	dosbin dump-utmp dump-acct accton sa || die "dosbin failed"
	doinfo accounting.info
	doman *.[18]
	dodoc AUTHORS ChangeLog INSTALL NEWS README ToDo
	keepdir /var/account
	exeinto /etc/init.d
	newexe "${FILESDIR}/acct.rc6" acct
}
