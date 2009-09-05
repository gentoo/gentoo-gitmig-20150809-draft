# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-9999.ebuild,v 1.1 2009/09/05 21:41:21 scarabeus Exp $

EAPI=1

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

inherit cmake-utils git

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug test"

RDEPEND="
	>=x11-libx/qt-gui-4.5.0:4
	>=x11-libs/qt-webkit-4.5.0:4
"
DEPEND="${RDEPEND}
	test? ( x11-libs/qt-test:4 )
"
