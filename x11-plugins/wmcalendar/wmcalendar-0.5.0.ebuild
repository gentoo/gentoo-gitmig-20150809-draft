# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalendar/wmcalendar-0.5.0.ebuild,v 1.5 2004/11/24 05:17:43 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmCalendar is a calendar dockapp for Windowmaker."

HOMEPAGE="http://wmcalendar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

DEPEND="virtual/x11
			>=dev-libs/libical-0.24_rc4
			>=dev-util/pkgconfig-0.15.0
			>=x11-libs/gtk+-2.2.1-r1"

# default Makefile overwrites CC and CFAGS variables so we patch it
src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${P}.makefile.patch
}

S=${WORKDIR}/${P}/Src

src_install() {
	dodir /usr/bin /usr/man/man1
	make DESTDIR=${D}/usr install || die
	cd .. && dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO || die
}
