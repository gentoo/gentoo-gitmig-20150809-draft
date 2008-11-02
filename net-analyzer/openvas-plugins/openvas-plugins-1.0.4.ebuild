# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-plugins/openvas-plugins-1.0.4.ebuild,v 1.1 2008/11/02 06:48:24 hanno Exp $

inherit eutils

DESCRIPTION="A remote security scanner for Linux (openvas-plugins)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/523/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="net-analyzer/openvas-server"
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-respect-ldflags.diff" || die "epatch failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc docs/*.txt || die "dodoc failed"
}
