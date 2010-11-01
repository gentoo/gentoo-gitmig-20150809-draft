# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/upnpscan/upnpscan-0.4-r2.ebuild,v 1.2 2010/11/01 04:32:45 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/wp/upnpscan/"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PF}-cflags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
