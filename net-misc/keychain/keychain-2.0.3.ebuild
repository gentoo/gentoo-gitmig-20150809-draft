# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-2.0.3.ebuild,v 1.8 2004/03/11 23:56:05 mr_bones_ Exp $

DESCRIPTION="A front-end to ssh-agent"
HOMEPAGE="http://www.gentoo.org/proj/en/keychain.xml"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.bz2"

KEYWORDS="x86 ~ppc sparc ~alpha ~mips ~hppa amd64 ia64 ppc64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	app-shells/bash
	net-misc/openssh
	|| (
		sys-apps/coreutils
		sys-apps/sh-utils
	)"

src_install() {
	dobin keychain || die "dobin failed"
	dodoc ChangeLog README || die "dodoc failed"
	doman keychain.1 || die "doman failed"
}
