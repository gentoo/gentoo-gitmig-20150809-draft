# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/lamp/lamp-20000903.ebuild,v 1.1 2000/09/08 20:32:25 achim Exp $

P=lamp-2000.09.03
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Video Player for mpeg2/3, avi and quicktime movie"
SRC_URI="http://pauillac.inria.fr/lamp/src/${A}"
HOMEPAGE="http://pauillac.inria.fr/lamp/"

src_unpack () {
  unpack ${A}
  sed -e "s:-g:${CFLAGS}:" ${FILESDIR}/Makefile.config > ${S}/Makefile.config
}

src_compile() {

    cd ${S}
    unset CFLAGS
    make depend
    make world

}

src_install () {

    cd ${S}
    make installroot=${D} install
    rmdir ${D}/usr/libexec/lamp/avifile_codecs
    cp ${FILESDIR}/config ${D}/usr/libexec/lamp
    dodoc ANNOUNCE ChangeLog COPYING CREDITS README* TODO USAGE FAQ docs/Xv.txt
    docinto html
    dodoc docs/*.html
    
}


