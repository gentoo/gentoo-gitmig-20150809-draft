# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/napshare/napshare-1.2.ebuild,v 1.4 2004/03/01 06:26:59 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NapShare is a fully automated Gnutella P2P client made to run 24/7 unattended"
SRC_URI="mirror://sourceforge/napshare/${P}.tar.gz"
HOMEPAGE="http://napshare.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND=""

src_compile() {
	econf
	emake
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"
}
