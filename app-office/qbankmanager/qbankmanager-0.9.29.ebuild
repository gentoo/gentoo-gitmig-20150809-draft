# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.29.ebuild,v 1.1 2005/09/26 16:19:50 hanno Exp $

inherit eutils qt3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-1.6.0_beta
	=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/editcategoryreport.ui.gz ${S}/src/kbanking/libs/reports
	gunzip ${S}/src/kbanking/libs/reports/editcategoryreport.ui.gz
}

src_compile() {
	econf `use_enable debug` || die
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
