# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header$

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="ftp://"
HOMEPAGE="http://"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

