# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag  Mehta <pm@gentoo.org> 
#$Header: /var/cvsroot/gentoo-x86/net-www/prozilla/prozilla-1.3.6.ebuild,v 1.1 2001/08/19 03:35:48 pm Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A download manager"
SRC_URI="http://prozilla.delrom.ro/tarballs/${A}"
HOMEPAGE="http://prozilla.delrom.ro/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
    try ./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man \
	--host=${CHOST} --sysconfdir=/etc
    try make
}

src_install () {
    try make DESTDIR=${D} install

    dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO

}

