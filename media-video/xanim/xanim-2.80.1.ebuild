# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim/xanim-2.80.1.ebuild,v 1.4 2000/11/02 08:31:51 achim Exp $

A="xanim2801.tar.gz xa1.0_cyuv_linuxELFg21.o.gz xa2.0_cvid_linuxELFg21.o.gz
   xa2.1_iv32_linuxELFg21.o.gz"
S=${WORKDIR}/xanim2801
DESCRIPTION="XAnim"
SRC_URI="ftp://xanim.va.pubnix.com/xanim2801.tar.gz
	 ftp://xanim.va.pubnix.com/modules/xa1.0_cyuv_linuxELFg21.o.gz
	 ftp://xanim.va.pubnix.com/modules/xa2.0_cvid_linuxELFg21.o.gz
	 ftp://xanim.va.pubnix.com/modules/xa2.1_iv32_linuxELFg21.o.gz"
HOMEPAGE="http://xanim.va.pubnix.com"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack xanim2801.tar.gz
  mkdir ${S}/mods
  cd ${S}/mods
  cp ${DISTDIR}/xa1.0_cyuv_linuxELFg21.o.gz .
  gunzip xa1.0_cyuv_linuxELFg21.o.gz
  cp ${DISTDIR}/xa2.0_cvid_linuxELFg21.o.gz .
  gunzip xa2.0_cvid_linuxELFg21.o.gz
  cp ${DISTDIR}/xa2.1_iv32_linuxELFg21.o.gz .
  gunzip xa2.1_iv32_linuxELFg21.o.gz
  sed -e "s:-O2:${CFLAGS}:" ${FILESDIR}/Makefile > ${S}/Makefile
}
src_compile() {

    cd ${S}
    try make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin xanim
    newman docs/xanim.man xanim.1
    insinto /usr/libexec/xanim/mods
    doins mods/*
    dodoc README
    dodoc docs/README.* docs/*.readme docs/*.doc
}

