# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org> 

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A download manager"
SRC_URI="http://www.lintux.cx/~kalum/${A}"
HOMEPAGE="http://www.lintux.cx/~kalum/prozilla.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} --sysconfdir=/etc
    try make
}

src_install () {
    try make DESTDIR=${D} install

    dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO

}

