# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-2.6.6.ebuild,v 1.3 2006/10/17 14:23:32 uberlord Exp $

DESCRIPTION="ssh-agent manager"
HOMEPAGE="http://www.gentoo.org/proj/en/keychain/"
SRC_URI="http://dev.gentoo.org/~agriffis/keychain/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sparc ~sparc-fbsd x86 x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-shells/bash
	|| ( net-misc/openssh net-misc/ssh )"

src_install() {
	dobin keychain || die "dobin failed"
	dodoc ChangeLog keychain.pod README
	doman keychain.1 || die "doman failed"
}

pkg_postinst() {
	echo
	einfo "Please see the Keychain Guide at"
	einfo "http://www.gentoo.org/doc/en/keychain-guide.xml"
	einfo "for help getting keychain running"
	echo
}
