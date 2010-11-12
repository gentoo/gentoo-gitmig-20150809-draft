# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-9999.ebuild,v 1.6 2010/11/12 15:33:02 scarabeus Exp $

EAPI=3

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"
QT_REQUIRED="4.6.0"
inherit qt4-r2 git

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
SRC_URI=""

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS=""
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
