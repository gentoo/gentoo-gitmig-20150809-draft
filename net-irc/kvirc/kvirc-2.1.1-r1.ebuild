# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-2.1.1-r1.ebuild,v 1.9 2002/08/01 11:59:03 seemant Exp $
use kde && 
use kde && inherit kde-base

S=${WORKDIR}/${P}
DESCRIPTION="A IRC Client for KDE"
SRC_URI="ftp://ftp.kvirc.net/kvirc/2.1.1/source/${P}.tar.bz2"
HOMEPAGE="http://www.kvirc.net"

DEPEND="$DEPEND virtual/glibc
        =x11-libs/qt-2.3*"

use kde && need-kde 2.1

SLOT="2"
LICENSE="kvirc"
KEYWORDS="x86"

src_unpack() {
    cd ${WORKDIR}
    unpack ${A}
}

src_compile() {
    use kde && myconf="${myconf} --with-kde-support"
    
    use kde && kde_src_compile myconf
    ./configure --mandir=/usr/share/man --infodir=/usr/share/info \
	--host=${CHOST} ${myconf} --prefix=/usr || die

    make kvirc || die
}

src_install () {
    make install DESTDIR=${D} || die
    make docs DESTDIR=${D} || die

    rm -rf ${D}/${KDEDIR}/man
    doman data/man/kvirc.1

    dodoc ChangeLog INSTALL README TODO
    
}
