# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aqmoney/aqmoney-0.6.2.ebuild,v 1.4 2004/06/24 22:01:46 agriffis Exp $

DESCRIPTION="Textmode HBCI online banking tool"
HOMEPAGE="http://aqmoney.sourceforge.net/"
SRC_URI="mirror://sourceforge/aqmoney/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/openhbci-0.9.12"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README INSTALL AUTHORS ChangeLog
}
