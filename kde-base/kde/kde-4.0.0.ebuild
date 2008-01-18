# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-4.0.0.ebuild,v 1.2 2008/01/18 13:46:03 ingmar Exp $

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
	~kde-base/kdelibs-${PV}:${SLOT}
	~kde-base/kdepimlibs-${PV}:${SLOT}
	~kde-base/kdebase-${PV}:${SLOT}
	~kde-base/kdeadmin-${PV}:${SLOT}
	~kde-base/kdeartwork-${PV}:${SLOT}
	~kde-base/kdeedu-${PV}:${SLOT}
	~kde-base/kdegames-${PV}:${SLOT}
	~kde-base/kdegraphics-${PV}:${SLOT}
	~kde-base/kdemultimedia-${PV}:${SLOT}
	~kde-base/kdenetwork-${PV}:${SLOT}
	~kde-base/kdetoys-${PV}:${SLOT}
	~kde-base/kdeutils-${PV}:${SLOT}
	accessibility? ( ~kde-base/kdeaccessibility-${PV}:${SLOT} )"
