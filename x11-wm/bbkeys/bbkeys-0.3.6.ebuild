# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="bbkeys"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${A}"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

DEPEND=">=x11-wm/blackbox-0.61 qt? ( >=x11-libs/qt-x11-2.3.0 )"

src_compile() {

    if [ "`use qt`" ] ; then
      cd ${S}/bbkeysconf-1.3
      try make "QTDIR=${QTDIR} MOC=${QTDIR}/bin/moc CXXFLAGS='${CXXFLAGS} -I/usr/lib -I/usr/X11R6/include -I${QTDIR}/include'"
      cd ${S}
    fi
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    if [ "`use qt`" ] ; then
      cd ${S}/bbkeysconf-1.3
      try make DESTDIR=${D} PREFIX=${D}/usr/X11R6/bin install
      cd ${S}
    fi
    try make DESTDIR=${D} install
    cd /usr/X11R6/bin/wm
    cp blackbox blackbox.bak
    sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbkeys \&\n&": blackbox.bak > blackbox
}

