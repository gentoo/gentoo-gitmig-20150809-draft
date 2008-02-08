# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-1.0.0.ebuild,v 1.1 2008/02/08 12:58:40 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/393/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/gnutls
	net-libs/libpcap"

src_install() {
	einstall || die "failed to install"
	dodoc ChangeLog CHANGES TODO || die
}
