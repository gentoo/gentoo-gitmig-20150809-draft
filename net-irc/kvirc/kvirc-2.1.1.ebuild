# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-2.1.1.ebuild,v 1.8 2001/09/22 08:39:14 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A IRC Client for KDE"
SRC_URI="ftp://ftp.kvirc.net/kvirc/2.1.1/source/${P}.tar.bz2"
HOMEPAGE="http://www.kvirc.net"

DEPEND="virtual/glibc
        >=x11-libs/qt-x11-2.3
        kde? ( kde-base/kdelibs )"

src_compile() {
    local myconf
    use kde && myconf="${myconf} --with-kde-support"

    ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
	--host=${CHOST} ${myconf} || die

    make kvirc || die
}

src_install () {
    make install DESTDIR=${D} || die
    make docs DESTDIR=${D} || die

    rm -rf ${D}/usr/man
    doman data/man/kvirc.1

    dodoc ChangeLog INSTALL README TODO
}
