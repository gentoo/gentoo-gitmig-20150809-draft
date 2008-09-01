# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.50.ebuild,v 1.1 2008/09/01 17:39:56 hanno Exp $

inherit eutils qt3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://files.hboeck.de/aq/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-3.7.2
	=x11-libs/qt-3*"
S=${WORKDIR}/${P/_/}

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
	dodoc AUTHORS README TODO README NEWS || die
}
