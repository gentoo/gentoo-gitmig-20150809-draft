# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.5.6.ebuild,v 1.4 2007/02/04 18:18:39 jer Exp $

inherit kde-dist

DESCRIPTION="KDE artwork package"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_compile() {
	local myconf="--with-dpms --with-libart
	              $(use_with opengl gl) $(use_with xscreensaver)"

	kde_src_compile
}
