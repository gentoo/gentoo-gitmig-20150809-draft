# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnssec-nodes/dnssec-nodes-1.12-r1.ebuild,v 1.1 2012/06/23 20:21:48 xmw Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="graphically depicts the DNSSEC results from a lookup from logfiles"
HOMEPAGE="http://www.dnssec-tools.org"
SRC_URI="http://www.dnssec-tools.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-dns/dnssec-tools[threads]"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake4 ${PN}.pro PREFIX=/usr
}

src_install() {
	qt4-r2_src_install

	doicon icons/dnssec-nodes.*
	make_desktop_entry ${PN}

	doman man/${PN}.1
}
