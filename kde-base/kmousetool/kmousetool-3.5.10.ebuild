# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-3.5.10.ebuild,v 1.3 2009/05/31 19:43:26 nixnut Exp $
KMNAME=kdeaccessibility
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/libXtst"
