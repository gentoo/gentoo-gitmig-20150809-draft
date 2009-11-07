# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-client/openvas-client-2.0.5.ebuild,v 1.2 2009/11/07 20:19:43 volkmar Exp $

inherit eutils

DESCRIPTION="A client for the openvas vulnerability scanner"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/617/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

DEPEND="net-libs/gnutls
	gtk? ( >=x11-libs/gtk+-2.8.8 )"
RDEPEND="${DEPEND}"

# Upstream bug:
# http://wald.intevation.org/tracker/index.php?func=detail&aid=941&group_id=29&atid=220
MAKEOPTS="-j1"

src_compile() {
	econf $(use_enable gtk) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CHANGES README TODO || die "dodoc failed"

	make_desktop_entry OpenVAS-Client "OpenVAS Client" /usr/share/pixmaps/openvas-client.png "Network"
}
