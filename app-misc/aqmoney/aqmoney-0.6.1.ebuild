# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aqmoney/aqmoney-0.6.1.ebuild,v 1.2 2003/07/11 19:30:24 aliz Exp $

DESCRIPTION="Textmode HBCI online banking tool"
HOMEPAGE="http://aqmoney.sourceforge.net/"
SRC_URI="mirror://sourceforge/aqmoney/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=net-libs/openhbci-0.9.11"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README INSTALL AUTHORS ChangeLog
}
