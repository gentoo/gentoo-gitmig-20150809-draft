# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-plugins/openvas-plugins-1.0.0.ebuild,v 1.1 2008/02/08 13:19:34 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-plugins)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/412/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-analyzer/openvas-server"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc docs/*.txt || die "dodoc failed"
}
