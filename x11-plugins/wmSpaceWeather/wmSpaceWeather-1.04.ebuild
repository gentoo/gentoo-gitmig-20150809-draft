# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSpaceWeather/wmSpaceWeather-1.04.ebuild,v 1.1 2002/10/08 14:30:47 raker Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="dockapp showing weather at geosynchronous orbit."
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	sys-devel/perl
	virtual/x11
	x11-wm/WindowMaker"
RDEPEND="${DEPEND}"

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
