# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/jinit/jinit-0.1.9-r1.ebuild,v 1.1 2001/05/28 05:24:13 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An alternative to sysvinit which supports the need(8) concept"
SRC_URI="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/download/${A}"
HOMEPAGE="http://homepage.ntlworld.com/john.fremlin/programs/linux/jinit/
          http://www.atnf.csiro.au/~rgooch/linux/boot-scripts/"

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

