# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/supervise-scripts/supervise-scripts-3.4.ebuild,v 1.2 2005/03/03 18:38:32 ciaranm Exp $

DESCRIPTION="Starting and stopping daemontools managed services"
HOMEPAGE="http://untroubled.org/supervise-scripts/"
SRC_URI="http://untroubled.org/supervise-scripts/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=sys-process/daemontools-0.70"

src_compile() {
	echo '/usr/bin' > conf-bin
	emake || die
}

src_install() {
	dobin \
		svc-add svc-isdown svc-isup svc-remove \
		svc-start svc-status svc-stop \
		svc-waitdown svc-waitup svscan-add-to-inittab \
		svscan-start svscan-stopall || die
	dodoc ANNOUNCEMENT ChangeLog NEWS README TODO VERSION
	doman *.[0-9]
}
