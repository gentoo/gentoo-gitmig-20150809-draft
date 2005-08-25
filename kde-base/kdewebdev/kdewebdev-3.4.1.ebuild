# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.4.1.ebuild,v 1.11 2005/08/25 17:35:27 agriffis Exp $

inherit kde-dist flag-o-matic

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="doc tidy"

DEPEND="~kde-base/kdebase-${PV}"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"

# Remove this when libxslt-1.1.14-r1 goes stable (#98345)
append-flags -DFORCE_DEBUGGER
