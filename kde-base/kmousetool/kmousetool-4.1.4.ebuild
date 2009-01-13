# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.1.4.ebuild,v 1.1 2009/01/13 22:21:28 alexxy Exp $

EAPI="2"

KMNAME=kdeaccessibility
inherit kde4-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="
	>=kde-base/knotify-${PV}:${SLOT}
	media-sound/phonon"
