# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSpaceWeather/wmSpaceWeather-1.04.ebuild,v 1.8 2004/03/26 23:10:07 aliz Exp $

IUSE=""

DESCRIPTION="dockapp showing weather at geosynchronous orbit."
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~mips"

DEPEND="dev-lang/perl
	virtual/x11"

src_compile() {
	emake -C wmSpaceWeather clean || die "make clean failed"

	COPTS=${CFLAGS} emake -C wmSpaceWeather \
		|| die "parallel make failed"
}

src_install() {
	dobin wmSpaceWeather/wmSpaceWeather wmSpaceWeather/GetKp
	doman wmSpaceWeather/wmSpaceWeather.1
	dodoc BUGS CHANGES HINTS README
}
