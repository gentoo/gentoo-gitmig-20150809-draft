# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-0.2.ebuild,v 1.1 2010/08/04 18:00:45 scarabeus Exp $

EAPI=2

inherit qt4-r2

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND="
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-sql-4.6.0:4[sqlite]
	>=x11-libs/qt-webkit-4.6.0:4
"
DEPEND="${RDEPEND}
	test? ( x11-libs/qt-test:4 )
"

RESTRICT="test"

src_configure() {
	eqmake4 PREFIX=/usr
}
