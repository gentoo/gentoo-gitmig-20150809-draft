# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/egressor/egressor-1.0.ebuild,v 1.4 2003/07/13 11:30:10 aliz Exp $

DESCRIPTION="tool for checking router configuration"
HOMEPAGE="http://www.packetfactory.net/projects/egressor/"
SRC_URI="http://www.packetfactory.net/projects/${PN}/${PN}_release${PV}.tar.gz"

LICENSE="egressor"
SLOT="0"
KEYWORDS="x86"

DEPEND="=net-libs/libnet-1.0*"
RDEPEND="net-libs/libpcap
	dev-perl/Net-RawIP
	dev-lang/perl"

S=${WORKDIR}

src_compile() {
	cd client
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin client/egressor server/egressor_server.pl
	dodoc README client/README-CLIENT server/README-SERVER
}
