# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.3.2.ebuild,v 1.1 2004/12/07 15:21:29 hanno Exp $

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://www.unix-ag.uni-kl.de/~massar/vpnc/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/libgcrypt-1.1.91
	sys-apps/iproute2"

S=${WORKDIR}/${P}

src_compile() {
	# Workaround for crappy Makefile
	sed -i -e "s:CFLAGS=-W -Wall -O:CFLAGS=${CFLAGS}:" Makefile
	emake || die
}

src_install() {
	dobin vpnc vpnc-connect vpnc-disconnect || die
	dodoc ChangeLog README TODO VERSION
	doman vpnc.8
	insinto /etc
	doins vpnc.conf
}
