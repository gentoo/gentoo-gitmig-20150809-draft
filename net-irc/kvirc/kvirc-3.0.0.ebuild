# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author  Maarten Stolte <datadevil@crash.nu>
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-3.0.0.ebuild,v 1.1 2002/01/27 13:48:26 verwilst Exp $

S=${WORKDIR}/kvirc-3.0.0-xmas
DESCRIPTION="An IRC Client for QT 3"
SRC_URI="ftp://ftp.kvirc.net/kvirc/3.0.0xmas/source/${P}-xmas.tar.gz"
HOMEPAGE="http://www.kvirc.net"

DEPEND="virtual/glibc
        >=x11-libs/qt-3.0"

src_unpack() {

    cd ${WORKDIR}
    unpack ${P}-xmas.tar.gz

}

src_compile() {

    ./configure --mandir=/usr/share/man --infodir=/usr/share/info \
	--host=${CHOST} --prefix=/usr || die

    make kvirc || die
}

src_install () {
    
    make install DESTDIR=${D} || die
    make docs DESTDIR=${D} || die

    dodoc ChangeLog INSTALL README TODO
    
}


