# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-9999.ebuild,v 1.8 2011/01/11 22:13:36 scarabeus Exp $

EAPI=3

QT_REQUIRED="4.6.0"
inherit qt4-r2

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"
	inherit git
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
IUSE="debug test"

RDEPEND="
	>=x11-libs/qt-gui-${QT_REQUIRED}:4
	>=x11-libs/qt-sql-${QT_REQUIRED}:4[sqlite]
	>=x11-libs/qt-webkit-${QT_REQUIRED}:4
"
DEPEND="${RDEPEND}
	test? ( >=x11-libs/qt-test-${QT_REQUIRED}:4 )
"

src_configure() {
	eqmake4 PREFIX=/usr
}
