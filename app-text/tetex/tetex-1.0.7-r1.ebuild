# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r1.ebuild,v 1.6 2000/10/05 00:12:58 achim Exp $

P=tetex-1.0.7
A="teTeX-src-1.0.7.tar.gz teTeX-texmf-1.0.2.tar.gz"
S=${WORKDIR}/teTeX-1.0
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-1.0.7.tar.gz
	 ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-texmf-1.0.2.tar.gz"
HOMEPAGE="http://tug.cs.umb.edu/tetex/"

src_unpack() {
  unpack teTeX-src-1.0.7.tar.gz
  mkdir texmf
  cd texmf
  unpack teTeX-texmf-1.0.2.tar.gz
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --bindir=/usr/bin
  try make
  try make
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr/share
  cp -a ../texmf ${D}/usr/share/
  make prefix=${D}/usr bindir=${D}/usr/bin texmf=${D}/usr/share/texmf install

  prepman
  prepinfo

  dodoc PROBLEMS README
  docinto texk
  dodoc texk/ChangeLog texk/README
  docinto kpathesa
  cd ${S}/texk/kpathsea
  dodoc README* NEWS PROJECTS HIER
  docinto dviljk
  cd ${S}/texk/dviljk
  dodoc AUTHORS README NEWS
  docinto dvipsk
  cd ${S}/texk/dvipsk
  dodoc AUTHORS ChangeLog INSTALLATION README
  docinto makeindexk
  cd ${S}/texk/makeindexk
  dodoc CONTRIB COPYING NEWS NOTES PORTING README
  docinto ps2pkm
  cd ${S}/texk/ps2pkm
  dodoc ChangeLog CHANGES.type1 INSTALLATION README* 
  docinto web2c
  cd ${S}/texk/web2c
  dodoc AUTHORS ChangeLog NEWS PROJECTS README
  docinto xdvik
  cd ${S}/texk/xdvik
  dodoc BUGS FAQ README* 

}







