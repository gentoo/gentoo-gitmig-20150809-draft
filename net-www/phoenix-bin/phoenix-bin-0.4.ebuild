# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/phoenix-bin/phoenix-bin-0.4.ebuild,v 1.3 2002/11/07 19:36:05 phoenix Exp $

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="The Phoenix Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/${MY_PN}/releases/${PV}/${MY_PN}-${PV}-i686-pc-linux-gnu.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/phoenix/"
RESTRICT="nostrip"

KEYWORDS="~x86"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"

RDEPEND=">=sys-libs/lib-compat-1.0-r2
	 >=x11-libs/gtk+-1.2.10-r9
	 virtual/x11"

src_install() {
	dodir /usr/lib

	mv ${S} ${D}/usr/lib
	chown -R root.root ${D}/usr/lib/${MY_PN}

	dobin ${FILESDIR}/phoenix
	dosym /usr/lib/libstdc++-libc6.1-1.so.2 /usr/lib/${MY_PN}/libstdc++-libc6.2-2.so.3
}
