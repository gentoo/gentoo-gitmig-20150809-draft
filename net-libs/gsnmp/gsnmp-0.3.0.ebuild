# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gsnmp/gsnmp-0.3.0.ebuild,v 1.1 2011/06/01 02:12:08 jer Exp $

EAPI=3

inherit autotools-utils

DESCRIPTION="An SNMP library based on glib and gnet"
HOMEPAGE="ftp://ftp.ibr.cs.tu-bs.de/pub/local/gsnmp/"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="
	dev-libs/glib:2
	net-libs/gnet
"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
	use static-libs || remove_libtool_files
}
