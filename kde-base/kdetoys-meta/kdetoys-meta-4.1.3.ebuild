# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.1.3.ebuild,v 1.1 2008/11/09 11:55:33 scarabeus Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/amor-${PV}:${SLOT}
	>=kde-base/kteatime-${PV}:${SLOT}
	>=kde-base/ktux-${PV}:${SLOT}
	>=kde-base/kweather-${PV}:${SLOT}
"
