# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtz/wmtz-0.7.ebuild,v 1.12 2005/05/16 07:48:28 s4t4n Exp $

inherit eutils toolchain-funcs

IUSE=""
DESCRIPTION="dockapp that shows the time in multiple timezones."
SRC_URI="http://www.geocities.com/jl1n/wmtz/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/jl1n/wmtz/wmtz.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}

	#apply both patches to compile with gcc-3.4 closing bug #64556
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/wmtz-0.7-gcc34.patch
	fi
}

src_compile() {
	cd ${S}/wmtz
	epatch ${FILESDIR}/wmtz.c.patch
	emake FLAGS="$CFLAGS" || die
}

src_install () {
	dobin wmtz/wmtz
	insinto /etc
	doins wmtz/wmtzrc
	dodoc BUGS CHANGES COPYING README INSTALL
}
