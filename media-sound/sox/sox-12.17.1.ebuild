# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.1.ebuild,v 1.1 2000/11/26 12:52:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The swiss army knife of sound processing programs"
SRC_URI="http://download.sourceforge.net/sox/${A}"
HOMEPAGE="http://home.sprynet.com/~cgabwell/sox.html"

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-sound/alsa-driver-0.5.9"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-fast-ulaw --enable-fast-alaw --with-alsa-dsp
    try make

}

src_install () {

    cd ${S}
    into /usr
    dobin sox
    doman sox.1
    dodoc Changelog Copyright README TODO *.txt

}




