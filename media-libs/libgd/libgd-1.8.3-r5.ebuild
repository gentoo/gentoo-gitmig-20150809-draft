# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.3-r5.ebuild,v 1.11 2003/04/23 00:13:19 lostlogic Exp $

IUSE="X"

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ppc sparc "

DEPEND="=sys-apps/sed-4*
	media-libs/libpng
	X? ( virtual/x11 )
	jpeg? ( media-libs/jpeg )
	truetype? ( =media-libs/freetype-1.3* )"

src_unpack() {

	unpack ${A}
	cd ${S}

	local compopts
	local libsopts

	use X \
		&& compopts="${compopts} -DHAVE_XPM" \
		&& libsopts="${libsopts} -lXpm -lX11"
	
	use jpeg \
		&& compopts="${compopts} -DHAVE_JPEG" \
		&& libsopts="${libsopts} -ljpeg"

	
	compopts="${compopts} -DHAVE_PNG" \
	libsopts="${libsopts} -lpng"
	
	use truetype \
		&& compopts="${compopts} -DHAVE_LIBTTF" \
		&& libsopts="${libsopts} -lttf"
	
	if use truetype
	then
		sed -i -e "s:^\(CFLAGS\)=.*:\1=${CFLAGS} ${compopts} :" \
			-e "s:^\(LIBS\)=.*:\1=-lm -lgd -lz ${libsopts}:" \
			-e "s:^\(INCLUDEDIRS\)=:\1=-I/usr/include/freetype :" \
		Makefile
	else
		sed -i -e "s:^\(CFLAGS\)=.*:\1=${CFLAGS} ${compopts} :" \
		-e "s:^\(LIBS\)=.*:\1=-lm -lgd -lz ${libsopts}:" \
		Makefile
	fi

}

src_compile() {

	emake || die

}

src_install() {
	
	dodir /usr/{bin,lib,include}
	
	make \
		INSTALL_LIB=${D}/usr/lib \
		INSTALL_BIN=${D}/usr/bin \
		INSTALL_INCLUDE=${D}/usr/include \
		install || die
	
	preplib /usr

	dodoc readme.txt
	dohtml -r ./
}
