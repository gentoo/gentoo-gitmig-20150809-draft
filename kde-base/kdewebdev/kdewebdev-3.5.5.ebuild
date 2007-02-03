# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.5.5.ebuild,v 1.11 2007/02/03 15:40:15 eroyf Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc kdehiddenvisibility tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"
