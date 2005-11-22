# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.5.0.ebuild,v 1.1 2005/11/22 22:14:00 danarmak Exp $

inherit kde-dist

DESCRIPTION="KDE artwork package"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
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
