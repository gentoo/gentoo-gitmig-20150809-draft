# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.6.3.ebuild,v 1.1 2000/09/16 17:23:33 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI=ftp://ftp.rxvt.org/pub/rxvt/${A}
HOMEPAGE=http://www.rxvt.org

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --enable-next-scroll --enable-transparency --enable-xpm-background --enable-utmp --enable-wtmp
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  prepman /usr/X11R6
  prepstrip /usr/X11R6/bin/rxvt /usr/X11R6/bin/rclock  
  dodoc doc/README* doc/*.html doc/*.txt doc/BUGS doc/FAQ  
}




