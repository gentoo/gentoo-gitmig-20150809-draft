# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netdiscover/netdiscover-0.3_beta5.ebuild,v 1.1 2005/09/01 12:39:12 s4t4n Exp $

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

IUSE=""

DESCRIPTION="An active/passive address reconnaissance tool."
HOMEPAGE="http://nixgeneration.com/~jaime/netdiscover/"
SRC_URI="http://nixgeneration.com/~jaime/netdiscover/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libnet-1.1.2.1-r1
	>=net-libs/libpcap-0.8.3-r1"

S=${WORKDIR}/${MY_P}

src_install()
{
	dobin src/netdiscover
	dodoc AUTHORS README TODO
}
