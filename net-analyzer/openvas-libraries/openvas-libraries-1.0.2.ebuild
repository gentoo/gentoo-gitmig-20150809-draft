# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-1.0.2.ebuild,v 1.2 2008/08/18 11:49:15 pva Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/467/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/gnutls
	net-libs/libpcap"

src_install() {
	einstall || die "failed to install"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog CHANGES TODO || die
}
