# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmspaceclock/wmspaceclock-1.1.ebuild,v 1.4 2003/10/16 16:10:23 drobbins Exp $

DESCRIPTION="A sexy anti-aliased dockapp clock"
HOMEPAGE="http://wmspaceclock.sourceforge.net"
SRC_URI="mirror://sourceforge/wmspaceclock/${P/wm/}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
DEPEND="virtual/glibc
	virtual/x11
	>=dev-libs/STLport-4.5.3
	>=media-libs/gdk-pixbuf-0.20"
S=${WORKDIR}/spaceclock

src_compile() {
	cd ${S}
	cp Makefile Makefile.orig
	sed \
		-e "s:/usr/local:/usr:" \
		-e "s:-g3 -O2:${CFLAGS}:" \
		< Makefile.orig > Makefile
	make
}

src_install() {
	dodir /usr/bin
	make DESTDIR=${D} install || die
}
