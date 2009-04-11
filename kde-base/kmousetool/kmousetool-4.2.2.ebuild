# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.2.2.ebuild,v 1.1 2009/04/11 23:29:41 alexxy Exp $

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc"

RDEPEND="
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
"
