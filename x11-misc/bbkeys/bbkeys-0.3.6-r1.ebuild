# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.3.6-r1.ebuild,v 1.1 2001/08/29 15:17:38 lamer Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${A}"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

DEPEND=">=x11-wm/blackbox-0.61 qt? ( >=x11-libs/qt-x11-2.3.0 )"

src_compile() {

    if [ "`use qt`" ] ; then
      cd ${S}/bbkeysconf-1.3
      local qtdir=${QTDIR}
      try make MOC=${qtdir}/bin/moc CXXFLAGS="-I${qtdir}/include" LIBS="-L${qtdir}/lib -L/usr/X11R6/lib -lqt -lX11"
    fi
    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    if [ "`use qt`" ] ; then
      cd ${S}/bbkeysconf-1.3
      into /usr/X11R6
      dobin bbkeysconf
    fi
    cd ${S}
    try make DESTDIR=${D} install
    cd /usr/X11R6/bin/wm
    cp blackbox blackbox.bak
    sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbkeys \&\n&": blackbox.bak > blackbox
}

