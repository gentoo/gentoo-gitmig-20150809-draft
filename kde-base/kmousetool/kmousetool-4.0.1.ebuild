# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.0.1.ebuild,v 1.1 2008/02/07 00:12:09 philantrop Exp $

EAPI="1"

KMNAME=kdeaccessibility
inherit kde4-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="|| ( ( >=kde-base/knotify-${PV}:${SLOT} >=kde-base/phonon-${PV}:${SLOT} )
		>=kde-base/kdebase-${PV}:${SLOT} )"
