# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeysconf/bbkeysconf-1.3-r3.ebuild,v 1.10 2002/07/29 16:10:41 seemant Exp $

inherit kde base || die		# note: base is intended to override kde!

DESCRIPTION="Configure bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${P}.tar.gz"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=x11-wm/blackbox-0.61 >=x11-misc/bbkeys-0.8.2"

src_compile() {

	need-qt 2.3.1
	make MOC=${QTDIR}/bin/moc CXXFLAGS="-g ${CXXFLAGS} -I${QTDIR}/include" LIBS="-L/usr/X11R6/lib -L${QTDIR}/lib -lqt -lX11" || die
	
}

src_install () {

	into /usr
	dobin bbkeysconf
}
