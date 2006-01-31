# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtz/wmtz-0.7.ebuild,v 1.15 2006/01/31 21:01:53 nelchael Exp $

inherit eutils toolchain-funcs

IUSE=""
DESCRIPTION="dockapp that shows the time in multiple timezones."
SRC_URI="http://www.geocities.com/jl1n/wmtz/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/jl1n/wmtz/wmtz.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	#apply both patches to compile with gcc-3.4 closing bug #64556
	epatch ${FILESDIR}/wmtz-0.7-gcc34.patch
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
	dodoc BUGS CHANGES README
}
