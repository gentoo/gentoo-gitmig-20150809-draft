# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openmotif/openmotif-MLI-2.1.30.ebuild,v 1.1 2000/09/20 20:12:48 achim Exp $

A=openmotif-2.1.30-4_MLI.src.tar.gz
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/"${A}
HOMEPAGE="http://www.metrolink.com/openmotif/"

src_unpack() {
  unpack ${A}
  cp ${O}/files/site.def ${S}/config/cf/
}

src_compile() {                           
  cd ${S}
  mkdir -p imports/x11
  cd imports/x11
  ln -s /usr/X11R6/bin bin
  ln -s /usr/X11R6/include include
  ln -s /usr/X11R6/lib lib
  cd ${S}
  try make World
}

src_install() {                               
#  cd ${S}/bindings
#  cp Makefile Makefile.orig
#  sed -e "s:sun_mit:sun_at:" -e "s:sun_news:sun:" Makefile.orig > Makefile
  cd ${S}
  try make DESTDIR=${D} VARDIR=${D}/var/X11/ install
}







