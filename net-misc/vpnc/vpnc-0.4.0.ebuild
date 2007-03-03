# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.4.0.ebuild,v 1.5 2007/03/03 14:08:01 beandog Exp $

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://www.unix-ag.uni-kl.de/~massar/${PN}/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-libs/libgcrypt-1.1.91
	>=sys-apps/iproute2-2.6.19.20061214"

src_compile() {
	emake || die
}

src_install() {
	emake PREFIX="/usr" DESTDIR=${D} install || die
	dodoc ChangeLog README TODO VERSION
	keepdir /var/run/vpnc
	dobin pcf2vpnc
	doinitd ${FILESDIR}/vpnc
}
