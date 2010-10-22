# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/upnpscan/upnpscan-0.4-r1.ebuild,v 1.1 2010/10/22 01:34:13 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/wp/upnpscan/"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags.patch
	eautoreconf
}

src_compile() {
	if use static ; then
		econf || die
	else
		econf --enable-static=no || die
	fi
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin "${S}"/src/upnpscan || die
}
