# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-2.0.ebuild,v 1.3 2010/07/13 14:39:29 fauli Exp $

EAPI=2

QT_MINIMAL="4.6.0"
inherit kde4-base

DESCRIPTION="A simple chess board for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/Knights?content=122046"
SRC_URI="http://kde-apps.org/CONTENT/content-files/122046-${P/_}-src.tar.gz"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug"

DEPEND=">=kde-base/libkdegames-${KDE_MINIMAL}"

S=${WORKDIR}/${PN/k/K}

src_prepare() {
	echo "Categories=Game;BoardGame;" >> src/${PN}.desktop

	kde4-base_src_prepare
}
