# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtz/wmtz-0.7.ebuild,v 1.1 2002/10/24 19:12:24 raker Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="dockapp that shows the time in multiple timezones."
SRC_URI="http://www.geocities.com/jl1n/wmtz/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/jl1n/wmtz/wmtz.html"

DEPEND="virtual/x11 x11-wm/WindowMaker virtual/glibc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

src_compile() {

	cd ${S}/wmtz
	emake CFLAGS="$CFLAGS"  || die

}

src_install () {

	dobin wmtz/wmtz

	dodoc BUGS CHANGES COPYING README INSTALL wmtz/wmtzrc

}
