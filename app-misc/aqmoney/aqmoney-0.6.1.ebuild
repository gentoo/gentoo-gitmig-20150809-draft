# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aqmoney/aqmoney-0.6.1.ebuild,v 1.3 2004/03/14 10:48:30 mr_bones_ Exp $

DESCRIPTION="Textmode HBCI online banking tool"
HOMEPAGE="http://aqmoney.sourceforge.net/"
SRC_URI="mirror://sourceforge/aqmoney/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/openhbci-0.9.11"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README INSTALL AUTHORS ChangeLog
}
