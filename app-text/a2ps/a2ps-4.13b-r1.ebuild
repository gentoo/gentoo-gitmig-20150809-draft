# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r1.ebuild,v 1.2 2000/08/16 04:37:55 drobbins Exp $

P=a2ps-4.13b
A=${P}.tar.gz
S=${WORKDIR}/a2ps-4.13
DESCRIPTION="a2ps is an Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/"${A}
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps"
src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/a2ps --with-catgets
  make
}

src_install() {                               
  cd ${S}
  dodir /usr/share/emacs/site-lisp
  make prefix=${D}/usr sysconfdir=${D}/etc/a2ps install
  dodoc ANNOUNCE AUTHORS ChangeLog COPYING FAQ NEWS README THANKS TODO
  prepman
  prepinfo
}




