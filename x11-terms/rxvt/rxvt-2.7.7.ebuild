# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.7.7.ebuild,v 1.1 2001/08/09 23:10:56 blocke Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI="ftp://ftp.rxvt.org/pub/rxvt/${A}"
#SRC_URI="http://prdownloads.sourceforge.net/rxvt/${A}"
HOMEPAGE=http://www.rxvt.org

DEPEND="virtual/glibc virtual/x11"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --enable-next-scroll \
        --enable-transparency --enable-xpm-background --enable-utmp --enable-wtmp \
	--enable-mousewheel --enable-slipwheeling --enable-smart-resize \
	--enable-menubar --enable-shared --enable-keepscrolling

  try make
}

src_install() {

  try make prefix=${D}/usr/X11R6 install
  dodoc doc/README* doc/*.html doc/*.txt doc/BUGS doc/FAQ

}




