# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-0.9.5.ebuild,v 1.2 2000/11/02 02:17:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="ftp://ftp.gnucash.org/pub/g-wrap/source/${A}"
HOMEPAGE="http://"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-util/guile-1.4"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

