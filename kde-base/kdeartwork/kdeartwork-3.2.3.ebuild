# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.2.3.ebuild,v 1.5 2004/07/22 05:17:34 lv Exp $

inherit kde-dist

DESCRIPTION="KDE artwork package"

KEYWORDS="x86 ~ppc ~sparc ~alpha hppa amd64 ~ia64 ~mips"
IUSE="opengl"

DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}"

src_compile() {
	myconf="$myconf --with-dpms `use_with opengl gl`"
	kde_src_compile
}
