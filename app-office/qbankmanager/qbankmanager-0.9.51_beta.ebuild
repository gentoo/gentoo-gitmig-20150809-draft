# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.51_beta.ebuild,v 1.1 2009/06/01 21:34:58 hanno Exp $

EAPI="2"

inherit eutils qt3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=04&release=04&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-3.7.2[qt3]
	=x11-libs/qt-3*"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P/_/}"
MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	econf PATH="/usr/qt/3/bin:${PATH}" \
		`use_enable debug` || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README TODO README NEWS || die
}
