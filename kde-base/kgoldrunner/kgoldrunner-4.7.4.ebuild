# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgoldrunner/kgoldrunner-4.7.4.ebuild,v 1.2 2012/01/09 16:39:08 phajdan.jr Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE: KGoldrunner is a game of action and puzzle solving"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}"
