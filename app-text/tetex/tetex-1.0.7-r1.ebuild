# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r1.ebuild,v 1.1 2000/08/07 15:31:45 achim Exp $

P=tetex-1.0.7
A="teTeX-src-1.0.7.tar.gz teTeX-texmf-1.0.2.tar.gz"
S=${WORKDIR}/teTeX-1.0
CATEGORY="app-text"
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-1.0.7.tar.gz
	 ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-texmf-1.0.2.tar.gz"
HOMEPAGE="http://tug.cd.umb.edu/tetex/"

src_unpack() {
  unpack teTeX-src-1.0.7.tar.gz
  mkdir texmf
  cd texmf
#  unpack teTeX-texmf-1.0.2.tar.gz
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  dodir /usr/share
  cp -a ../texmf ${D}/usr/share/
  make prefix=${D}/usr install
}




