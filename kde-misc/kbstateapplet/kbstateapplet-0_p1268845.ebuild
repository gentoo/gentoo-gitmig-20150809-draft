# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbstateapplet/kbstateapplet-0_p1268845.ebuild,v 1.2 2012/01/22 21:36:41 johu Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Plasmoid that shows the state of keyboard leds"
HOMEPAGE="http://websvn.kde.org/trunk/playground/base/plasma/applets/kbstateapplet"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"
