# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/avifile/avifile-0.46.1.ebuild,v 1.1 2000/09/08 19:06:35 achim Exp $

A="${P}.tar.gz binaries.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Library for AVI-Files"
SRC_URI="http://divx.euro.ru/${P}.tar.gz
	 http://divx.euro.ru/binaries.zip"

HOMEPAGE="http://divx.euro.ru/"

src_unpack () {
  unpack ${P}.tar.gz
}

src_compile() {

    cd ${S}
    ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--with-win32-path=/usr/libexec/avifile/win32
    make

}

src_install () {

    cd ${S}
    dodir /usr/X11R6/lib /usr/X11R6/bin
    make prefix=${D}/usr/X11R6 install
    dodir /usr/libexec/avifile/win32
    cd ${D}/usr/libexec/avifile/win32
    unzip ${DISTDIR}/binaries.zip
}



