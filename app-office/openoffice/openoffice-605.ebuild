# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-605.ebuild,v 1.2 2000/10/18 06:16:17 achim Exp $

P=oo_605_src
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Open Office"
SRC_URI="http://anoncvs.openoffice.org/download/OpenOffice${PV}/${A}"
HOMEPAGE="http://www.openoffice.org"


src_compile() {

    cd ${S}/config_office
    try ./configure --prefix=/opt/oo --host=${CHOST}

    cd ${S}

    try dmake

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}


