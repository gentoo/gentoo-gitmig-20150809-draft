# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-0.2.5.ebuild,v 1.3 2000/09/18 07:05:59 drobbins Exp $

A=lincvs_${PV}.tar.gz
S=${WORKDIR}/LinCVS-0.2.5
DESCRIPTION="A Graphical CVS Frontend"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/lincvs/download/${A}"
HOMEPAGE="http://www.lincvs.de"
BUILD_DEP="kde-base/qt"

src_unpack () {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}	

src_compile() {

    cd ${S}
    try make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin LinCVS
    dodoc AUTHORS COPYING ChangeLog README.TXT VERSION.TXT
    

}

