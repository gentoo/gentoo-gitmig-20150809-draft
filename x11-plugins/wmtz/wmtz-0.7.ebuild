# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtz/wmtz-0.7.ebuild,v 1.3 2003/02/13 17:33:10 vapier Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="dockapp that shows the time in multiple timezones."
SRC_URI="http://www.geocities.com/jl1n/wmtz/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/jl1n/wmtz/wmtz.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	cd ${S}/wmtz
	emake CFLAGS="$CFLAGS"  || die
}

src_install () {
	dobin wmtz/wmtz
	insinto /etc
	doins wmtz/wmtzrc
	dodoc BUGS CHANGES COPYING README INSTALL
}
