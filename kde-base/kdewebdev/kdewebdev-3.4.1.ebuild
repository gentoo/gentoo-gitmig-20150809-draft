# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.4.1.ebuild,v 1.4 2005/07/01 04:56:28 josejx Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="amd64 ~ia64 ppc ~sparc x86"
IUSE="doc tidy"

DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )"
