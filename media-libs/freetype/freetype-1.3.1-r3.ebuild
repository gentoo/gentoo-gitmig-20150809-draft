# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-1.3.1-r3.ebuild,v 1.5 2002/07/16 11:36:46 seemant Exp $

# r3 change by me (danarmak): there's a contrib dir inside the freetype1
# sources with important utils: ttf2bdf, ttf2pfb, ttf2pk, ttfbanner.
# These aren't build together with the main tree: you must configure/make
# separately in each util's directory. However ttf2pfb doesn't compile
# properly. Therefore we download freetype1-contrib.tar.gz which is newer
# and coresponds to freetype-pre1.4. (We don't have an ebuild for that
# because it's not stable?) We extract it to freetype-1.3.1/freetype1-contrib
# and build from there.
# When we update to freetype-pre1.4 or any later version, we should use
# the included contrib directory and not download any additional files.

A1=${P}.tar.gz
A2=freetype1-contrib.tar.gz
A="${A1} ${A2}"
S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://ftp.freetype.org/pub/freetype1/${A1}
	 ftp://ftp.freetype.org/pub/freetype1/${A2}"
HOMEPAGE="http://www.freetype.org/"

SLOT="1"
LICENSE="FTL"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {
    
    cd ${WORKDIR}
    unpack ${A1}
    # freetype1-contrib goes under freetype-1.3.1
    cd ${S}
    unpack ${A2}
    
}

src_compile() {

  local myconf

  if [ -z "`use nls`" ]
  then
    myconf="${myconf} --disable-nls"
  fi

  try ./configure --host=${CHOST} --prefix=/usr ${myconf}

  # Make a small fix to disable tests
  # Now xfree is no longer required
  cp Makefile Makefile.orig
  sed -e "s:ttlib tttest ttpo:ttlib ttpo:" Makefile.orig > Makefile

  try make
  
  # make contrib utils
  for x in ttf2bdf ttf2pfb ttf2pk ttfbanner
  do
    cd ${S}/freetype1-contrib/${x}
    try ./configure --host=${CHOST} --prefix=/usr
    try make
  done

}

src_install() {

  cd lib

  # Seems to require a shared libintl (getetxt comes only with a static one
  # But it seems to work without problems

  try make -f arch/unix/Makefile prefix=${D}/usr install
  cd ../po
  try make prefix=${D}/usr install
  cd ..
  dodoc announce PATENTS README readme.1st
  dodoc docs/*.txt docs/FAQ docs/TODO
  docinto html
  dodoc docs/*.htm
  docinto html/image
  dodoc docs/image/*.gif docs/image/*.png
  
  # install contrib utils
  cd ${S}/freetype1-contrib
  into /usr
  dobin ttf2bdf/ttf2bdf \
	ttf2pfb/getafm ttf2pfb/t1asm ttf2pfb/.libs/ttf2pfb \
	ttf2pk/.libs/ttf2pk ttf2pk/.libs/ttf2tfm \
	ttfbanner/.libs/ttfbanner
  cp ttf2bdf/ttf2bdf.man ttf2bdf/ttf2bdf.man.1
  doman ttf2bdf/ttf2bdf.man.1
  docinto contrib
  dodoc ttf2pk/ttf2pk.doc
  
}
