# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.16.ebuild,v 1.2 2000/08/16 04:38:10 drobbins Exp $

P=sox-12.16
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The swiss army knife of sound processing programs"
SRC_URI="http://metalab.unc.edu/pub/Linux/apps/sound/convert/${A}"
HOMEPAGE="http://home.sprynet.com/~cgabwell/sox.html"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST} \
	 --enable-fast-ulaw --enable-fast-alaw
    make

}

src_install () {

    cd ${S}
    into /usr
    dobin sox
    doman sox.1
    dodoc CHEAT README sox.txt TIPS TODO

}


