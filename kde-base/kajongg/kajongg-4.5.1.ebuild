# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kajongg/kajongg-4.5.1.ebuild,v 1.2 2010/09/06 04:51:16 reavertm Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdegames"
inherit kde4-meta python

DESCRIPTION="The classical Mah Jongg for four players"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-db/sqlite:3
	$(add_kdebase_dep libkdegames)
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	>=dev-python/twisted-8.2.0
"
