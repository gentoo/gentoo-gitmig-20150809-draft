# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmweather/wmweather-1.31-r1.ebuild,v 1.1 2002/04/25 17:06:54 seemant Exp $

# Because of the capital "W" in the package name
WMW_PACKAGE=wmWeather

S="${WORKDIR}/${WMW_PACKAGE}-${PV}"

DESCRIPTION="Dockable applette for WindowMaker that shows weather."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${WMW_PACKAGE}-${PV}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
DEPEND="x11-base/xfree
	sys-devel/perl"

src_compile() {
	emake CFLAGS="$CFLAGS" -C Src || die
}

src_install () {
	dobin Src/wmWeather Src/GrabWeather
	dodoc BUGS CHANGES COPYING HINTS INSTALL
}
