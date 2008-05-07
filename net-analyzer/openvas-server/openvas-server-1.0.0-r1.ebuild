# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-server/openvas-server-1.0.0-r1.ebuild,v 1.1 2008/05/07 21:51:01 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-server)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/407/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcpd gtk debug prelude"

DEPEND=">=net-analyzer/openvas-libraries-1.0.1
	net-analyzer/openvas-libnasl
	tcpd? ( sys-apps/tcp-wrappers )
	gtk? ( =x11-libs/gtk+-2* )
	prelude? ( dev-libs/libprelude )"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf \
		$(use_enable tcpd tcpwrappers) \
		$(use_enable debug) \
		$(use_enable gtk) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc TODO CHANGES || die
	dodoc doc/*.txt doc/ntp/* || die

	doinitd "${FILESDIR}"/openvasd || die "doinitd failed"
	keepdir /var/lib/openvas/logs
	keepdir /var/lib/openvas/users
}
