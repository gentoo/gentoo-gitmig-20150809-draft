# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pathrate/pathrate-2.4.1.ebuild,v 1.1 2007/05/23 08:45:21 jokey Exp $

DESCRIPTION="Non-intrusive utility for estimation of capacity of Internet paths"
HOMEPAGE="http://www-static.cc.gatech.edu/fac/Constantinos.Dovrolis/pathrate.html"
SRC_URI="http://www-static.cc.gatech.edu/fac/Constantinos.Dovrolis/pathrate.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}_${PV}

src_install() {
	dobin "${S}"/pathrate_snd
	dobin "${S}"/pathrate_rcv
}
