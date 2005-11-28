# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.30_beta.ebuild,v 1.1 2005/11/28 23:52:17 hanno Exp $

inherit eutils qt3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-1.8.0_beta
	=x11-libs/qt-3*"
S=${WORKDIR}/${P/_/}

pkg_setup() {
	if ! built_with_use net-libs/aqbanking qt; then
		einfo "qbankmanager needs the qt-bindings of aqbanking."
		einfo "TO enable them, rebuild aqbanking with qt in USE."
		die "aqbanking was built without qt support."
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/qbankmanager-0.9.30beta-gcc41.patch
}

src_compile() {
	econf `use_enable debug` || die
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
