# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-0.3_alpha2.ebuild,v 1.1 2000/09/20 20:12:47 achim Exp $

A=lincvs-0.3alpha2.tgz
S=${WORKDIR}/LinCVS-0.3alpha2
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/lincvs/download/${A}"
HOMEPAGE="http://www.lincvs.de"

src_unpack () {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}	

src_compile() {

    cd ${S}
    make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin LinCVS
    insinto /usr/share/icons
    doins res/*.xpm
    
    dodoc AUTHORS COPYING ChangeLog README.TXT VERSION.TXT
    

}


