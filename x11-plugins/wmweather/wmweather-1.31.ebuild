# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather/wmweather-1.31.ebuild,v 1.2 2002/10/04 06:46:12 vapier Exp $

MY_P=${P/wmw/wmW}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dockable applette for WindowMaker that shows weather."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${MY_P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/x11
	sys-devel/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake CFLAGS="$CFLAGS" -C Src || die
}

src_install () {
	dobin Src/wmWeather Src/GrabWeather
	dodoc BUGS CHANGES COPYING HINTS INSTALL
}
