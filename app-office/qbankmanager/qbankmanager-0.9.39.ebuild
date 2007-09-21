# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.39.ebuild,v 1.4 2007/09/21 13:32:11 opfer Exp $

inherit eutils qt3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-2.2.5
	=x11-libs/qt-3*"
S=${WORKDIR}/${P}

pkg_setup() {
	if ! built_with_use net-libs/aqbanking qt3; then
		eerror "qbankmanager needs the qt3-bindings of aqbanking."
		eerror "To enable them, rebuild aqbanking with qt3 in USE."
		die "aqbanking was built without qt3 support."
	fi
}

src_compile() {
	econf PATH="/usr/qt/3/bin:${PATH}" \
		`use_enable debug` || die
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
