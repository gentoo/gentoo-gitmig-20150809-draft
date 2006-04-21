# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/upnpscan/upnpscan-0.4.ebuild,v 1.2 2006/04/21 22:35:19 vanquirius Exp $

DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/tools.jsp?id=23"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="static"

DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	if use static ; then
		econf || die
	else
		econf --enable-static=no || die
	fi
	emake || die
}

src_install() {
	dobin "${S}"/src/upnpscan || die
}
