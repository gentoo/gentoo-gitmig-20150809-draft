# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmspaceclock/wmspaceclock-1.2d.ebuild,v 1.3 2004/07/25 20:59:09 s4t4n Exp $

DESCRIPTION="A sexy anti-aliased dockapp clock"
HOMEPAGE="http://wmspaceclock.sourceforge.net"
SRC_URI="mirror://sourceforge/wmspaceclock/${P/wm/}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/libc
	virtual/x11
	>=media-libs/gdk-pixbuf-0.20
	>=sys-apps/sed-4"
S=${WORKDIR}/spaceclock

src_unpack()
{
	unpack ${A}
	cd ${S}

	# let't wipe out some dirt the author forgot in his tarball
	rm -fr pixmaps/.xvpics &>/dev/null
	rm -fr pixmaps/CVS     &>/dev/null
}

src_compile()
{
	sed	-i "s:/usr/local:/usr:" Makefile
	sed	-i "s:-g3 -O2:${CFLAGS}:" Makefile
	./configure
	make
}

src_install()
{
	dodir /usr/bin
	make DESTDIR=${D} install || die
}
