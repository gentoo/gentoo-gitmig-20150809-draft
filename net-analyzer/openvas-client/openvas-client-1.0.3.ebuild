# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-client/openvas-client-1.0.3.ebuild,v 1.1 2008/04/19 22:54:51 hanno Exp $

inherit eutils

DESCRIPTION="A client for the openvas vulnerability scanner"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/420/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/gnutls
	>=x11-libs/gtk+-2.8.8"
MAKEOPTS="${MAKEOPTS} -j1"

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS CHANGES README TODO || die "dodoc failed"

	make_desktop_entry OpenVASClient "OpenVAS Client" /usr/share/pixmaps/openvas-client.png "Application;Network;"
}
