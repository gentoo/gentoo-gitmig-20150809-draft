# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.4.ebuild,v 1.2 2001/02/20 02:56:59 pete Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a library of cd audio related routines"
SRC_URI="ftp://cdcd.undergrid.net/libcdaudio/${A}"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND="virtual/glibc
	virtual/kernel"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --enable-threads
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangLog NEWS README README.BeOS README.OSF1 TODO
}
