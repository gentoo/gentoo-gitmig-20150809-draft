# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.2.3.ebuild,v 1.6 2004/07/21 20:58:41 caleb Exp $

DESCRIPTION="KDE 3.2 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
IUSE=""

# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
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
	~kde-base/kdenetwork-${PV}
	~kde-base/kdetoys-${PV}
	~kde-base/kdeutils-${PV}
	~kde-base/kdeaccessibility-${PV}"
