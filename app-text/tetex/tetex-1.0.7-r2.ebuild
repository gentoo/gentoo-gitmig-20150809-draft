# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-1.0.7-r2.ebuild,v 1.3 2001/05/11 12:58:26 achim Exp $

P=tetex-1.0.7
A="teTeX-src-1.0.7.tar.gz teTeX-texmf-1.0.2.tar.gz ec-ready-mf-tfm.tar.gz teTeX-french.tar.gz"
S=${WORKDIR}/teTeX-1.0
DESCRIPTION="teTeX is a complete TeX distribution"
SRC_URI="ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-src-1.0.7.tar.gz
	 ftp://sunsite.informatik.rwth-aachen.de/pub/comp/tex/teTeX/1.0/distrib/sources/teTeX-texmf-1.0.2.tar.gz"

DEPEND="virtual/glibc sys-apps/ed
	>=media-libs/libpng-1.0.9
    libwww? ( >=net-libs/libwww-5.3.2-r1 )
	X? ( virtual/x11 )"

RDEPEND="virtual/glibc
    >=sys-devel/perl-5.2
	>=media-libs/libpng-1.0.9
	X? ( virtual/x11 )"

HOMEPAGE="http://tug.cs.umb.edu/tetex/"

src_unpack() {

  unpack teTeX-src-1.0.7.tar.gz
  cd ${S}

  patch -p0 < ${FILESDIR}/teTeX-1.0.dif
  mkdir texmf
  cd texmf
  tar xzf ${DISTDIR}/teTeX-texmf-1.0.2.tar.gz
  tar xzf ${DISTDIR}/ec-ready-mf-tfm.tar.gz -C ..
  tar xzf ${DISTDIR}/teTeX-french.tar.gz
  patch -p0 < ${FILESDIR}/texmf.dif


}

src_compile() {

  local myconf
  if [ "`use X`" ]
  then
    myconf="--with-x"
  else
    myconf="--without-x"
  fi

  if [ "`use libwww`" ]
  then
    myconf="${myconf} --with-system-wwwlib"
  fi
  # Does it make sense to compile the included libwww with mysql ?

  try ./configure --host=${CHOST} --prefix=/usr --bindir=/usr/bin \
	    --mandir=/usr/share/man \
	    --infodir=/usr/share/info \
	    --datadir=${S} \
	    --without-texinfo \
	    --without-dialog \
	    --with-system-ncurses \
	    --with-system-zlib \
	    --with-system-pnglib \
        --enable-multiplatform \
	    --with-epsfwin \
	    --with-mftalkwin \
	    --with-regiswin \
	    --with-tektronixwin \
	    --with-unitermwin \
	    --with-ps=gs \
	    --enable-ipc \
	    --with-etex \
		${myconf}

  try make texmf=/usr/share/texmf

}

src_install() {                               
  cd ${S}
  dodir /usr/share/
  cp -af texmf ${D}/usr/share
  sed -e "s:\$(scriptdir)/texconfig init:echo:" Makefile > Makefile.install
  try make prefix=${D}/usr bindir=${D}/usr/bin \
	mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info \
	texmf=${D}/usr/share/texmf -f Makefile.install install


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





