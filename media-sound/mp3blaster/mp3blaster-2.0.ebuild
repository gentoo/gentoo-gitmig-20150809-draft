# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org> 

A=${P}b18.tar.gz
S=${WORKDIR}/mp3blaster-2.0b18/
DESCRIPTION="MP3 command line player"
SRC_URI="ftp://mud.stack.nl/pub/mp3blaster/${A}"
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster"

DEPEND=">=sys-libs/ncurses-5.2"


src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {
    try make DESTDIR=${D} install

    dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO

}

