# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.4.1.ebuild,v 1.10 2005/07/28 21:18:31 greg_g Exp $

inherit kde-dist flag-o-matic

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha amd64 ~ia64 ~mips ppc sparc x86 hppa"
IUSE="doc tidy"

DEPEND="~kde-base/kdebase-${PV}"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"

# Remove this when libxslt-1.1.14-r1 goes stable (#98345)
append-flags -DFORCE_DEBUGGER
