# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.4.0.ebuild,v 1.3 2005/03/22 21:37:12 carlo Exp $

DESCRIPTION="KDE - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
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
	accessibility? ( ~kde-base/kdeaccessibility-${PV} )"

# see bug 86284
#~kde-base/kdewebdev-${PV}