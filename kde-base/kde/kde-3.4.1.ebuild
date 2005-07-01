# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.4.1.ebuild,v 1.5 2005/07/01 04:56:28 josejx Exp $

DESCRIPTION="KDE - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86"
IUSE="accessibility"

# excluded: kdebindings, kdesdk, since these are developer-only packages
RDEPEND="~kde-base/kdelibs-${PV}
	~kde-base/kdebase-${PV}
	~kde-base/kdeaddons-${PV}
	~kde-base/kdeadmin-${PV}
	~kde-base/kdeartwork-${PV}
	~kde-base/kdeedu-${PV}
	~kde-base/kdegames-${PV}
	~kde-base/kdegraphics-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdepim-${PV}
	~kde-base/kdetoys-${PV}
	~kde-base/kdeutils-${PV}
	~kde-base/kdewebdev-${PV}
	accessibility? ( ~kde-base/kdeaccessibility-${PV} )"
