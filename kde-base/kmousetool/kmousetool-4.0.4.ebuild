# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.0.4.ebuild,v 1.1 2008/05/15 23:58:12 ingmar Exp $

EAPI="1"

KMNAME=kdeaccessibility
inherit kde4-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="
	>=kde-base/knotify-${PV}:${SLOT}
	>=kde-base/phonon-${PV}:${SLOT}"
