# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/jinit/jinit-0.1.9-r1.ebuild,v 1.5 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An alternative to sysvinit which supports the need(8) concept"
SRC_URI="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/download/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/
          http://www.atnf.csiro.au/~rgooch/linux/boot-scripts/"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    mv ${D}/usr/sbin ${D}
    mv ${D}/sbin/init ${D}/sbin/jinit
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
    cp -a example-setup ${D}/usr/share/doc/${PF}

    find ${D}/usr/share/doc/${PF}/example-setup -name "Makefile*"

}

