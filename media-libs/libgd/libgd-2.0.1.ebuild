# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Original from libgd-1.8.3-r3.ebuild slightly edited for libgd-2.0.1
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.1.ebuild,v 1.2 2002/09/14 12:39:18 mcummings Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/gd-2.0.1.patch.bz2"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	>=media-libs/freetype-2.0.9
	X? ( virtual/x11 )"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p <${FILESDIR}/gd-2.0.1.patch
	cp Makefile Makefile.orig
	if [ "`use X`" ]
	then
		sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_XPM -DHAVE_LIBJPEG -DHAVE_LIBFREETYPE -DHAVE_LIBPNG /" \
		-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lfreetype -lXpm -lX11/" \
		-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
		-e "s/^\(LIBDIRS\)=/\1=-L\$(INSTALL_LIB) /" \
		Makefile.orig > Makefile
	else
		sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_LIBJPEG -DHAVE_LIBFREETYPE -DHAVE_LIBPNG /" \
		-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lfreetype/" \
		-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
		-e "s/^\(LIBDIRS\)=/\1=-L\$(INSTALL_LIB) /" \
		Makefile.orig > Makefile
	fi

}

src_compile() {

	emake || die

}

src_install() {
	
	dodir /usr/{bin,lib,include}
	
	make 	\
		INSTALL_LIB=${D}/usr/lib	\
		INSTALL_BIN=${D}/usr/bin \
		INSTALL_INCLUDE=${D}/usr/include	\
		install || die
	
	preplib /usr

	dodoc readme.txt
	dohtml -r ./
}
