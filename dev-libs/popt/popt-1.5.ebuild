# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.5.ebuild,v 1.1 2001/06/21 19:45:54 lamer Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libpopt needed for lots of gnome stuff"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${A}"
HOMEPAGE="http://www.rpm.org"

DEPEND=""

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install

}

