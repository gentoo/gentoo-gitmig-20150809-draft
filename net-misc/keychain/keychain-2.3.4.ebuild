# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-2.3.4.ebuild,v 1.2 2004/07/29 01:54:03 agriffis Exp $

DESCRIPTION="ssh-agent manager"
HOMEPAGE="http://www.gentoo.org/proj/en/keychain.xml"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~agriffis/keychain/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	app-shells/bash
	sys-apps/coreutils
	|| ( net-misc/openssh net-misc/ssh )"

src_install() {
	dobin keychain || die "dobin failed"
	dodoc ChangeLog keychain.pod README
	doman keychain.1 || die "doman failed"
}
