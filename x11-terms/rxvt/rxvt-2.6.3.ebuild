# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.6.3.ebuild,v 1.3 2001/06/01 14:00:14 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI=ftp://ftp.rxvt.org/pub/rxvt/${A}
HOMEPAGE=http://www.rxvt.org

DEPEND="virtual/glibc virtual/x11"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --mandir=/usr/X11R6/share/man --enable-next-scroll \
        --enable-transparency --enable-xpm-background --enable-utmp --enable-wtmp
  try make
}

src_install() {

  try make prefix=${D}/usr/X11R6 mandir=${D}/usr/X11R6/share/man install
  dodoc doc/README* doc/*.html doc/*.txt doc/BUGS doc/FAQ

}




