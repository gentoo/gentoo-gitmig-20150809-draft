# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.12.4-r1.ebuild,v 1.3 2000/09/15 20:08:48 drobbins Exp $

P=librep-0.12.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Share library implementing a Lisp dialect"
SRC_URI="ftp://librep.sourceforge.net/pub/librep/"${A}
HOMEPAGE="http://librep.sourceforge.net/"


src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr aclocaldir=/${D}/usr/share/aclocal install
  prepinfo
  dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
  docinto doc
  dodoc doc/*
}



