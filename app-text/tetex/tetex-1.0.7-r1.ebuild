# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r1.ebuild,v 1.9 2000/11/01 04:44:13 achim Exp $

P=tetex-1.0.7
A="teTeX-src-1.0.7.tar.gz teTeX-texmf-1.0.2.tar.gz"
S=${WORKDIR}/teTeX-1.0
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-1.0.7.tar.gz
	 ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-texmf-1.0.2.tar.gz"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3
	>=media-libs/libpng-1.0.7
	>=x11-base/xfree-4.0.1"

HOMEPAGE="http://tug.cs.umb.edu/tetex/"

src_unpack() {

  unpack teTeX-src-1.0.7.tar.gz
  cd ${S}

  patch -p0 < ${FILESDIR}/teTeX-1.0.dif
  mkdir texmf
  cd texmf
  tar xzf ${DISTDIR}/teTeX-texmf-1.0.2.tar.gz
  tar xzf ${FILESDIR}/ec-ready-mf-tfm.tar.gz -C ..
  tar xzf ${FILESDIR}/teTeX-french.tar.gz
  patch -p0 < ${FILESDIR}/texmf.dif


}

src_compile() {                           

  cd ${S}

  try ./configure --host=${CHOST} --prefix=/usr --bindir=/usr/bin \
	    --datadir=${S} \
	    --without-texinfo \
	    --without-dialog \
	    --with-system-ncurses \
	    --with-system-zlib \
	    --with-system-pnglib \
	    --enable-multiplatform \
	    --with-x \
	    --with-epsfwin \
	    --with-mftalkwin \
	    --with-regiswin \
	    --with-tektronixwin \
	    --with-unitermwin \
	    --with-ps=gs \
	    --enable-ipc \
	    --with-etex

  try make texmf=/usr/share/texmf

}

src_install() {                               
  cd ${S}
  dodir /usr/share/
  cp -af texmf ${D}/usr/share
  sed -e "s:\$(scriptdir)/texconfig init:echo:" Makefile > Makefile.install
  try make prefix=${D}/usr bindir=${D}/usr/bin texmf=${D}/usr/share/texmf -f Makefile.install install


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


pkg_postinst() {
  if [ $ROOT = "/" ]
  then
    texconfig init
  fi
}





