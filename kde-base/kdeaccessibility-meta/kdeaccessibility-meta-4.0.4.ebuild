# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-4.0.4.ebuild,v 1.1 2008/05/15 23:03:26 ingmar Exp $

EAPI="1"

inherit kde4-functions

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-4"
KEYWORDS="~amd64 ~x86"
IUSE=""
# kde

RDEPEND="
	>=kde-base/kdeaccessibility-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeaccessibility-iconthemes-${PV}:${SLOT}
	>=kde-base/kmag-${PV}:${SLOT}
	>=kde-base/kmousetool-${PV}:${SLOT}
	>=kde-base/kmouth-${PV}:${SLOT}
	>=kde-base/kttsd-${PV}:${SLOT}
"

# FIXME:
# Disabled in 4.0.3 by upstream:
#	kde? ( >=kde-base/kbstateapplet-${PV}:${SLOT} )
#	>=kde-base/ksayit-${PV}:${SLOT}
