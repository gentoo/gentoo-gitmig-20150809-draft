# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.3-r5.ebuild,v 1.4 2002/08/07 05:09:50 gerk Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	~media-libs/freetype-1.3.1
	X? ( virtual/x11 )"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	if [ "`use X`" ]
	then
		sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_XPM -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
		-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lttf -lXpm -lX11/" \
		-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
		Makefile.orig > Makefile
	else
		sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
		-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lttf/" \
		-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
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
