# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmweather/wmweather-1.31.ebuild,v 1.5 2002/08/02 17:54:50 seemant Exp $

# Because of the capital "W" in the package name
WMW_PACKAGE=wmWeather

S="${WORKDIR}/${WMW_PACKAGE}-${PV}"

DESCRIPTION="Dockable applette for WindowMaker that shows weather."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${WMW_PACKAGE}-${PV}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
DEPEND="x11-base/xfree x11-wm/WindowMaker sys-devel/perl virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	emake CFLAGS="$CFLAGS" -C Src || die
}

src_install () {
	dobin Src/wmWeather Src/GrabWeather
	dodoc BUGS CHANGES COPYING HINTS INSTALL
}
