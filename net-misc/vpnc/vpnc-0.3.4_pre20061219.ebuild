# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.3.4_pre20061219.ebuild,v 1.1 2006/12/19 16:50:49 hanno Exp $

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND=">=dev-libs/libgcrypt-1.1.91
	>=sys-apps/iproute2-2.6.19.20061214"

src_compile() {
	emake || die
}

src_install() {
	dobin vpnc vpnc-disconnect pcf2vpnc
	dodoc ChangeLog README TODO VERSION
	doman vpnc.8
	insinto /etc
	doins vpnc.conf
	exeinto /etc/vpnc
	doexe vpnc-script
	keepdir /var/run/vpnc
}
