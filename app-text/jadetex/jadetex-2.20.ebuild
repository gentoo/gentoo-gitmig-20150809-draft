# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-2.20.ebuild,v 1.3 2001/01/24 18:11:47 achim Exp $

A="${P}.zip ${P}-makefile.patch"
S=${WORKDIR}/${P}
DESCRIPTION="TeX macros used by Jade TeX output."
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES//jadetex-2.20.zip
	 ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}-makefile.patch"
HOMEPAGE="http://"

DEPEND=">=app-arch/unzip-5.41
	>=app-text/tetex-1.0.7"

src_unpack() {

  mkdir ${S}
  cd ${S}
  unpack ${P}.zip
  patch -p0 < ${DISTDIR}/${P}-makefile.patch

}

src_compile() {

    cd ${S}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc ChangeLog
    doman *.1

    dodir /usr/bin
    cd ${D}/usr/bin
    ln -sf virtex jadetext
    ln -sf pdfvirtex pdfjadetex

}

