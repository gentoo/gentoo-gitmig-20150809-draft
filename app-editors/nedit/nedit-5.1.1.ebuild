# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.1.1.ebuild,v 1.2 2000/11/01 04:44:11 achim Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="ftp://ftp.nedit.org/pub/v5_1_1/${A}"
HOMEPAGE="http://nedit.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-util/yacc-1.9.1
	>=x11-base/xfree-4.0.1
	>=x11-wm/openmotif-MLI-2.1.30"
	
src_unpack() {
  unpack ${A}
  cd ${S}/makefiles
  cp Makefile.linux Makefile.orig
  sed -e "s:-O:${CFLAGS}:" Makefile.orig > Makefile.linux
}
src_compile() {

    cd ${S}
    try make linux

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin source/nc source/nedit
    newman nedit.man nedit.1
    newman nc.man nc.1
    dodoc README ReleaseNotes nedit.doc

}

