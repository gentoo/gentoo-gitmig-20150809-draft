# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.5.6.ebuild,v 1.3 2007/01/25 19:05:39 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc kdehiddenvisibility tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"
