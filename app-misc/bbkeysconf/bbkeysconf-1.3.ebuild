# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbkeysconf/bbkeysconf-1.3.ebuild,v 1.2 2001/08/15 19:23:16 lordjoe Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Configure bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${A}"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

DEPEND=">=x11-libs/qt-x11-2.3.0
	>=x11-wm/blackbox-0.61
	>=x11-wm/bbkeys-0.8.2"

src_compile() {

    local qtdir=${QTDIR}
    try make MOC=${qtdir}/bin/moc CXXFLAGS="-g -I${qtdir}/include ${CXXFLAGS}" LIBS="-L${qtdir}/lib -L/usr/X11R6/lib -lqt -lX11"
}

src_install () {

    into /usr/X11R6
    dobin bbkeysconf
}

