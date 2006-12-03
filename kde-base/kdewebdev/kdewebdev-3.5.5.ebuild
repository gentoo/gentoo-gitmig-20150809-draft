# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.5.5.ebuild,v 1.8 2006/12/03 19:46:00 corsair Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc kdehiddenvisibility tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"
