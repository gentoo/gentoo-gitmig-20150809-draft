# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-milestone-18.ebuild,v 1.1 2000/10/14 12:30:18 achim Exp $

A=mozilla-source-M${PV}.tar.gz
S=${WORKDIR}/mozilla
DESCRIPTION=""
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/m${PV}/src/${A}"
HOMEPAGE="http://www.mozilla.org"


src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/mozilla --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

