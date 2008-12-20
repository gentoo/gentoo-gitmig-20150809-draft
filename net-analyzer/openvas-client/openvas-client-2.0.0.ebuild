# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-client/openvas-client-2.0.0.ebuild,v 1.1 2008/12/20 23:48:34 hanno Exp $

inherit eutils

DESCRIPTION="A client for the openvas vulnerability scanner"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/551/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="net-libs/gnutls
	gtk? ( >=x11-libs/gtk+-2.8.8 )"

src_compile() {
	econf $(use_enable gtk) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CHANGES README TODO || die "dodoc failed"

	make_desktop_entry OpenVASClient "OpenVAS Client" /usr/share/pixmaps/openvas-client.png "Application;Network;"
}
