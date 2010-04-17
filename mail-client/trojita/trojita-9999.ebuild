# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-9999.ebuild,v 1.3 2010/04/17 11:18:25 scarabeus Exp $

EAPI=2

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

inherit qt4-r2 git

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug test"
RESTRICT="test"

RDEPEND="
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-webkit-4.6.0:4
"
DEPEND="${RDEPEND}
	test? ( x11-libs/qt-test:4 )
"

src_configure() {
	eqmake4 PREFIX=/usr
}
