# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim-export/xanim-export-2.80.1.ebuild,v 1.2 2000/09/08 20:44:21 achim Exp $

A="xanim_exporting_edition.tar.gz xa1.0_cyuv_linuxELFg21.o.gz xa2.0_cvid_linuxELFg21.o.gz
   xa2.1_iv32_linuxELFg21.o.gz"
S=${WORKDIR}/xanim_exporting_edition
DESCRIPTION="XAnim with Quicktime and RAW Audio export functions"
SRC_URI="http://heroine.linuxave.net/xanim_exporting_edition.tar.gz
	 ftp://xanim.va.pubnix.com/modules/xa1.0_cyuv_linuxELFg21.o.gz
	 ftp://xanim.va.pubnix.com/modules/xa2.0_cvid_linuxELFg21.o.gz
	 ftp://xanim.va.pubnix.com/modules/xa2.1_iv32_linuxELFg21.o.gz"
HOMEPAGE="http://heroin.linuxave.net/toys.html"


src_unpack() {
  unpack xanim_exporting_edition.tar.gz
  cd ${S}/mods
  cp ${DISTDIR}/xa1.0_cyuv_linuxELFg21.o.gz .
  gunzip xa1.0_cyuv_linuxELFg21.o.gz
  cp ${DISTDIR}/xa2.0_cvid_linuxELFg21.o.gz .
  gunzip xa2.0_cvid_linuxELFg21.o.gz
  cp ${DISTDIR}/xa2.1_iv32_linuxELFg21.o.gz .
  gunzip xa2.1_iv32_linuxELFg21.o.gz
  cd ${S}
  rm xanim
  sed -e "s:-O2:${CFLAGS}:" ${FILESDIR}/Makefile > ${S}/Makefile
#  cp ${FILESDIR}/*.h .
}
src_compile() {

    cd ${S}/quicktime
    make
    cd ..
    make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    newbin xanim xanim-export
    insinto /usr/libexec/xanim/mods
    doins mods/*
    dodoc README*
    dodoc docs/README.* docs/*.readme docs/*.doc
}



