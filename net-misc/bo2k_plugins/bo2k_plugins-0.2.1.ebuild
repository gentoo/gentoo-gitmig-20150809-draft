# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bo2k_plugins/bo2k_plugins-0.2.1.ebuild,v 1.3 2004/07/15 02:40:39 agriffis Exp $
DESCRIPTION="Plugin pack for LibBO2K."
HOMEPAGE="http://www.bo2k.com/"
SRC_URI="mirror://sourceforge/bo2k/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=net-libs/libbo2k-0.1.5_pre"
#RDEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README  COPYING INSTALL AUTHORS NEWS ChangeLog
}
