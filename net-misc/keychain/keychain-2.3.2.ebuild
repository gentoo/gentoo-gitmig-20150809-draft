# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-2.3.2.ebuild,v 1.1 2004/06/17 02:37:22 agriffis Exp $

DESCRIPTION="ssh-agent manager"
HOMEPAGE="http://www.gentoo.org/proj/en/keychain.xml"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~agriffis/keychain/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	app-shells/bash
	sys-apps/coreutils
	|| ( net-misc/openssh net-misc/ssh )"

src_install() {
	dobin keychain || die "dobin failed"
	dodoc ChangeLog COPYING keychain.pod README || die "dodoc failed"
	doman keychain.1 || die "doman failed"
}
