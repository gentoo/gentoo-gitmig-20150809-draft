# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeysconf/bbkeysconf-1.3-r3.ebuild,v 1.2 2001/12/16 19:57:06 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit base depend || die

S=${WORKDIR}/${P}
DESCRIPTION="Configure bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${P}.tar.gz"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

DEPEND=">=x11-wm/blackbox-0.61
	>=x11-misc/bbkeys-0.8.2"

src_compile() {
    
    need-qt 2.3.1
    set-qtdir
    make MOC=${QTDIR}/bin/moc CXXFLAGS="-g ${CXXFLAGS} -I${QTDIR}/include" LIBS="-L/usr/X11R6/lib -L${QTDIR}/lib -lqt -lX11" || die
    
}

src_install () {

    into /usr
    dobin bbkeysconf
}

