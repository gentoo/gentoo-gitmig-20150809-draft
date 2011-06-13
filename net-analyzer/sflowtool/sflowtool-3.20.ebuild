# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sflowtool/sflowtool-3.20.ebuild,v 1.3 2011/06/13 14:12:02 jer Exp $

EAPI="2"

inherit autotools flag-o-matic

DESCRIPTION="sflowtool is a utility for collecting and processing sFlow data"
HOMEPAGE="http://www.inmon.com/technology/sflowTools.php"
SRC_URI="http://www.inmon.com/bin/${P}.tar.gz"

LICENSE="inmon-sflow"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-ctype-header.patch
	eautoreconf
}

src_configure() {
	append-flags -DSPOOFSOURCE
	econf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
