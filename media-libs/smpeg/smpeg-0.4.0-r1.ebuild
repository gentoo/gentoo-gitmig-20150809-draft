# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.0-r1.ebuild,v 1.1 2000/08/08 22:13:30 achim Exp $

P=smpeg-0.4.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-libs"
DESCRIPTION="SDL MPEG Player Library"
SRC_URI="ftp://ftp.linuxgames.com/loki/open-source/smpeg/${A}"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST} 
    make

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install
   prepman
   dodoc CHANGES COPYING README* TODO
}




