# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-applet-daisy/plasma-applet-daisy-0.0.4.25-r1.ebuild,v 1.1 2012/03/08 12:18:53 johu Exp $

EAPI=4

KDE_MINIMAL="4.8"
inherit kde4-base

DESCRIPTION="Simple application launcher for KDE 4's plasma desktop"
HOMEPAGE="http://cdlszm.org/"
SRC_URI="http://cdlszm.org/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

PATCHES=(
	"${FILESDIR}/${P}-kde48.patch"
)
