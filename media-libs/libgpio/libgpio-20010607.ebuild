# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpio/libgpio-20010607.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

A=${PN}-cvs-${PV}.tar.bz2
S=${WORKDIR}/${PN}
DESCRIPTION="libgpio"
SRC_URI=""
HOMEPAGE="http://www-ghoto.org"

DEPEND="dev-libs/libusb sys-devel/automake sys-devel/autoconf sys-devel/libtool"
RDEPEND="dev-libs/libusb"


src_compile() {

    try ./autogen.sh --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install

}

