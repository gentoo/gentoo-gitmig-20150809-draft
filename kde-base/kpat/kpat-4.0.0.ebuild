# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpat/kpat-4.0.0.ebuild,v 1.1 2008/01/18 00:17:05 ingmar Exp $

EAPI="1"
KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="KDE patience game"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

# FIXME: Possibly unneeded dependency
#RDEPEND="${DEPEND}
#	>=kde-base/kdebase-data-${PV}:${SLOT}"
