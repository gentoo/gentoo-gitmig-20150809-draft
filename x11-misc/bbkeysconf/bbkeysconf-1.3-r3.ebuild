# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeysconf/bbkeysconf-1.3-r3.ebuild,v 1.4 2002/04/28 04:20:39 seemant Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde base || die		# note: base is intended to override kde!

DESCRIPTION="Configure bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${P}.tar.gz"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

newdepend ">=x11-wm/blackbox-0.61 >=x11-misc/bbkeys-0.8.2"

src_compile() {

	need-qt 2.3.1
	make MOC=${QTDIR}/bin/moc CXXFLAGS="-g ${CXXFLAGS} -I${QTDIR}/include" LIBS="-L/usr/X11R6/lib -L${QTDIR}/lib -lqt -lX11" || die
	
}

src_install () {

	into /usr
	dobin bbkeysconf
}

