# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-4.0.0.ebuild,v 1.1 2008/01/18 02:35:02 ingmar Exp $

EAPI="1"

DESCRIPTION="KDE - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="kde-4"
IUSE="accessibility"

# excluded: kdebindings, kdesdk, kdevelop, since these are developer-only packages
# excluded: kde-base/kdepim since this wasn't released with KDE 4.0.0
RDEPEND="
	kde-base/kdelibs:${SLOT}
	kde-base/kdepimlibs:${SLOT}
	kde-base/kdebase:${SLOT}
	kde-base/kdeadmin:${SLOT}
	kde-base/kdeartwork:${SLOT}
	kde-base/kdeedu:${SLOT}
	kde-base/kdegames:${SLOT}
	kde-base/kdegraphics:${SLOT}
	kde-base/kdemultimedia:${SLOT}
	kde-base/kdenetwork:${SLOT}
	kde-base/kdetoys:${SLOT}
	kde-base/kdeutils:${SLOT}
	accessibility? ( kde-base/kdeaccessibility:${SLOT} )"
