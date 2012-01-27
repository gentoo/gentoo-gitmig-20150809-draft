# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-2.4.1.ebuild,v 1.1 2012/01/27 12:23:34 johu Exp $

EAPI=4

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB es et fi fr it lt nb nds nl
pl pt pt_BR ru sr sr@latin sv tr ug uk zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A simple chess board for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/Knights?content=122046"
SRC_URI="http://dl.dropbox.com/u/2888238/Knights/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinst

	elog "No chess engines are emerged by default! If you want a chess engine"
	elog "to play with, you can emerge gnuchess or crafty."
}
