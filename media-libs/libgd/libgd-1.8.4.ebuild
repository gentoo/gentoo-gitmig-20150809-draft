# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.4.ebuild,v 1.4 2003/05/24 19:14:02 taviso Exp $

IUSE="X jpeg truetype"

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.boutell.com/gd/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="~x86 ~ppc ~sparc ~hppa"

DEPEND="media-libs/libpng
	X? ( virtual/x11 )
	jpeg? ( media-libs/jpeg )
	truetype? ( =media-libs/freetype-1.3* )"

src_unpack() {

	unpack ${A}
	cd ${S}

	local compopts
	local libsopts

	use alpha \
		&& [ "${CC}" == "ccc" ] && epatch ${FILESDIR}/gd-${PV}-dec-alpha-compiler.diff

	use X \
		&& compopts="${compopts} -DHAVE_XPM" \
		&& libsopts="${libsopts} -lXpm -lX11"
	
	use jpeg \
		&& compopts="${compopts} -DHAVE_LIBJPEG" \
		&& libsopts="${libsopts} -ljpeg"

	
	compopts="${compopts} -DHAVE_LIBPNG" \
	libsopts="${libsopts} -lpng"
	
	use truetype \
		&& compopts="${compopts} -DHAVE_LIBTTF" \
		&& libsopts="${libsopts} -lttf"
	
	mv Makefile Makefile.old || die
	if [ `use truetype` ]
	then
		sed -e "s:^\(CFLAGS\)=.*:\1=${CFLAGS} ${compopts} :" \
			-e "s:^\(LIBS\)=.*:\1=-lm -lgd -lz ${libsopts}:" \
			-e "s:^\(INCLUDEDIRS\)=:\1=-I/usr/include/freetype :" \
		Makefile.old > Makefile || die
	else
		sed -e "s:^\(CFLAGS\)=.*:\1=${CFLAGS} ${compopts} :" \
		-e "s:^\(LIBS\)=.*:\1=-lm -lgd -lz ${libsopts}:" \
		-e "s:\(COMPILER=\)gcc:\1${CC:-gcc}:" \
		Makefile.old > Makefile || die
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
