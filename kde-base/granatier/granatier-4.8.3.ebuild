# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/granatier/granatier-4.8.3.ebuild,v 1.1 2012/05/03 20:07:44 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}"
