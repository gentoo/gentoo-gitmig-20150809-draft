# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supervise-scripts/supervise-scripts-3.4.ebuild,v 1.11 2003/09/10 05:36:49 vapier Exp $

DESCRIPTION="Starting and stopping daemontools managed services."
HOMEPAGE="http://untroubled.org/supervise-scripts/"
SRC_URI="http://untroubled.org/supervise-scripts/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc"

RDEPEND=">=sys-apps/daemontools-0.70"

src_compile() {
	emake || die
}

src_install() {
	dobin \
		svc-add svc-isdown svc-isup svc-remove \
		svc-start svc-status svc-stop \
		svc-waitdown svc-waitup svscan-add-to-inittab
}
