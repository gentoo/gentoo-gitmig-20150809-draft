# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpeg-tools/mjpeg-tools-1a.ebuild,v 1.1 2000/08/15 17:34:07 achim Exp $

P=mjpeg-tools-1a
A="mjpeg_beta_1a.tar.gz quicktime4linux-1.1.9.tar.gz"
S=${WORKDIR}/mjpeg_beta
CATEGORY="media-video"
DESCRIPTION="Tools for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${A}
	 http://heroinewarrior.com/quicktime4linux-1.1.9.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

src_unpack() {
  unpack ${A}
  cd ${S}
  sed -e "s:-O2:${CFLAGS}:" ${O}/files/Makefile > Makefile
  cd aenc
  cp Makefile Makefile.orig
  sed -e "s:\.\./jpeg-6b-mmx/libjpeg\.a:-ljpeg:" Makefile.orig > Makefile
}
src_compile() {

    cd ${S}
    make
    cd aenc
    make
    cd ../mpegjoin
    make
    cd ../mplex
    make
}

src_install () {

    cd ${S}
    into /usr
    dobin lavplay lavrec lavvideo aenc/aenc mpegjoin/mpegjoin mplex/mplex
    dodoc BUGS CHANGES COPYING HINTS PLANS README* TODO
    newdoc aenc/README README.aenc
    newdoc mpegjoin/README README.mpegjoin
    docinto mplex
    dodoc mplex/COPYING mplex/INSTRUCT mplex/README


}


