# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtz/wmtz-0.7.ebuild,v 1.6 2004/04/07 12:26:58 pyrania Exp $

IUSE=""
DESCRIPTION="dockapp that shows the time in multiple timezones."
SRC_URI="http://www.geocities.com/jl1n/wmtz/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/jl1n/wmtz/wmtz.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_compile() {
	cd ${S}/wmtz
	epatch ${FILESDIR}/wmtz.c.patch
	emake CFLAGS="$CFLAGS"  || die
}

src_install () {
	dobin wmtz/wmtz
	insinto /etc
	doins wmtz/wmtzrc
	dodoc BUGS CHANGES COPYING README INSTALL
}
