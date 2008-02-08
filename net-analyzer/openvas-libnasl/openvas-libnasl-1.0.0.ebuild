# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libnasl/openvas-libnasl-1.0.0.ebuild,v 1.1 2008/02/08 13:02:43 hanno Exp $

inherit eutils

DESCRIPTION="A remote security scanner for Linux (openvas-libnasl)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/406/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-analyzer/openvas-libraries"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/openvas-libnasl-1.0.0-Makefile.patch"
}

src_install() {
	einstall || die "einstall failed"
	dodoc ChangeLog || die "dodoc failed"
}
