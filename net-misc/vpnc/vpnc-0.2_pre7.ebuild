# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.2_pre7.ebuild,v 1.1 2004/02/03 16:30:47 hanno Exp $

MY_P="vpnc-0.2-rm+zomb-pre7"
DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://www.unix-ag.uni-kl.de/~massar/vpnc/${MY_P}.tar.gz"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-libs/libgcrypt-1.1.91
	sys-apps/iproute"
S=${WORKDIR}/${MY_P}

src_compile() {
	# Workaround for crappy Makefile
	sed -i -e "s:CFLAGS=-W -Wall -O:CFLAGS=${CFLAGS}:" Makefile

	emake || die
}

src_install() {
	dobin vpnc vpnc-connect vpnc-disconnect
	dodoc ChangeLog README TODO VERSION
	insinto /etc
	doins vpnc.conf
}
