# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/phoenix-bin/phoenix-bin-0.3.ebuild,v 1.6 2003/02/13 15:41:57 vapier Exp $

IUSE=""

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="The Phoenix Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/phoenix/releases/0.3/phoenix-0.3-i686-pc-linux-gnu.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/phoenix/"
RESTRICT="nostrip"

KEYWORDS="x86 -ppc -sparc  -alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND=">=net-www/mozilla-1.0.1-r2
	 >=sys-libs/lib-compat-1.0-r2
	 virtual/x11"

src_install() {
	dodir /usr/lib

	mv ${S} ${D}/usr/lib
	chown -R root.root ${D}/usr/lib/${MY_PN}

	dobin ${FILESDIR}/phoenix
	dosym /usr/lib/libstdc++-libc6.1-1.so.2 /usr/lib/${MY_PN}/libstdc++-libc6.2-2.so.3
}
