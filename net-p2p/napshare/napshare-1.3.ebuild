# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/napshare/napshare-1.3.ebuild,v 1.2 2004/06/25 00:35:20 agriffis Exp $

DESCRIPTION="NapShare is a fully automated Gnutella P2P client made to run 24/7 unattended"
SRC_URI="mirror://sourceforge/napshare/${P}.tar.gz"
HOMEPAGE="http://napshare.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"
}
