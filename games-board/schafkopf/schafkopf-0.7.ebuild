# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/schafkopf/schafkopf-0.7.ebuild,v 1.3 2008/06/28 07:35:30 maekke Exp $

inherit kde

DESCRIPTION="a KDE version of a popular Bavarian card game"
HOMEPAGE="http://schafkopf.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="x86"
IUSE=""

DEPEND="|| ( kde-base/libkdegames >=kde-base/kdegames-3.2.0 )"

need-kde 3
