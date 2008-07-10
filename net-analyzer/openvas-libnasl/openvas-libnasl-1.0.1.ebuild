# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libnasl/openvas-libnasl-1.0.1.ebuild,v 1.1 2008/07/10 09:34:48 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libnasl)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/468/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-analyzer/openvas-libraries
	app-crypt/gpgme"

src_install() {
	einstall || die "einstall failed"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog || die "dodoc failed"
}
