# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.5.0.ebuild,v 1.1 2001/02/11 01:35:58 pete Exp $

#P=
A=${PN}-${PV}.tar.gz
S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="a library of cd audio related routines"
SRC_URI="ftp://cdcd.undergrid.net/cdcd/cdcd-0.5.0.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND=">=libcdaudio-0.99.4"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

