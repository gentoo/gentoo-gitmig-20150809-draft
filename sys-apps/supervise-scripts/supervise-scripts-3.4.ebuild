# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supervise-scripts/supervise-scripts-3.4.ebuild,v 1.13 2004/02/17 08:22:05 mr_bones_ Exp $

DESCRIPTION="Starting and stopping daemontools managed services."
HOMEPAGE="http://untroubled.org/supervise-scripts/"
SRC_URI="http://untroubled.org/supervise-scripts/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc"

RDEPEND=">=sys-apps/daemontools-0.70"

src_compile() {
	echo '/usr/bin' > conf-bin
	emake || die
}

src_install() {
	dobin \
		svc-add svc-isdown svc-isup svc-remove \
		svc-start svc-status svc-stop \
		svc-waitdown svc-waitup svscan-add-to-inittab \
		svscan-start svscan-stopall
	dodoc ANNOUNCEMENT COPYING ChangeLog NEWS README TODO VERSION
	doman *.[0-9]
}
