# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppconfig/pppconfig-2.3.11.ebuild,v 1.2 2005/05/27 06:38:33 josejx Exp $

DESCRIPTION="A text menu based utility for configuring ppp."
SRC_URI="http://http.us.debian.org/debian/pool/main/p/pppconfig/${PN}_${PV}.tar.gz"
HOMEPAGE="http://http.us.debian.org/debian/pool/main/p/pppconfig/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="net-dialup/ppp
		dev-util/dialog"

S=${WORKDIR}/${PN}

src_install () {
	 dodir /etc/chatscripts /etc/ppp/resolv
	 dosbin 0dns-down 0dns-up dns-clean
	 newsbin pppconfig pppconfig.real
	 dosbin ${FILESDIR}/pppconfig
	 doman pppconfig.8
	 dodoc debian/{copyright,changelog}
}
