# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-605.ebuild,v 1.1 2000/10/14 11:18:38 achim Exp $

A=oo_605_src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Open Office"
SRC_URI="http://anoncvs.openoffice.org/download/OpenOffice${PV}/${A}"
HOMEPAGE="http://www.openoffice.org"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

