# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.4-r2.ebuild,v 1.9 2004/03/25 07:11:48 mr_bones_ Exp $

MY_P=${P/lib/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz"

LICENSE="as-is | BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="X truetype freetype-version-1 jpeg"

DEPEND="media-libs/libpng
	jpeg? ( media-libs/jpeg )
	X? ( virtual/x11 )
	freetype-version-1? ( =media-libs/freetype-1* )
	!freetype-version-1?  (
		truetype? ( =media-libs/freetype-2* )
	)"

src_unpack() {
	unpack ${A}
	cd ${S}

	local compopts
	local libsopts
	local incopts

	use alpha \
		&& [ "${CC}" == "ccc" ] \
		&& epatch ${FILESDIR}/gd-${PV}-dec-alpha-compiler.diff

	use X \
		&& compopts="${compopts} -DHAVE_XPM" \
		&& libsopts="${libsopts} -lXpm -lX11"
	use jpeg \
		&& compopts="${compopts} -DHAVE_LIBJPEG" \
		&& libsopts="${libsopts} -ljpeg" \
		|| epatch ${FILESDIR}/${PV}-jpeg-inc.patch

	compopts="${compopts} -DHAVE_LIBPNG"
	libsopts="${libsopts} -lpng"

	if [ `use freetype-version-1` ] ; then
		compopts="${compopts} -DHAVE_LIBTTF"
		libsopts="${libsopts} -lttf"
		incopts="-I/usr/include/freetype"
	elif [ `use truetype` ] ; then
		compopts="${compopts} -DHAVE_LIBFREETYPE"
		libsopts="${libsopts} -lfreetype"
		incopts="-I/usr/include/freetype2"
	fi

	sed -i \
		-e "s:^\(CFLAGS\)=.*:\1=${CFLAGS} ${compopts} :" \
		-e "s:^\(LIBS\)=.*:\1=-lm -lgd -lz ${libsopts}:" \
		-e "s:^\(INCLUDEDIRS\)=:\1=${incopts} :" \
		-e "s:\(COMPILER=\)gcc:\1${CC:-gcc}:" \
		Makefile || die
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/{bin,lib,include/gd-1}
	make \
		INSTALL_LIB=${D}/usr/lib \
		INSTALL_BIN=${D}/usr/bin \
		INSTALL_INCLUDE=${D}/usr/include/gd-1 \
		install || die
	preplib /usr

	dodoc readme.txt
	dohtml -r ./

	# now make it slotable
	mv ${D}/usr/lib/libgd{,1}.a
	if `has_version =media-libs/libgd-2*` ; then
		rm -rf ${D}/usr/bin
	else
		dosym libgd1.a /usr/lib/libgd.a
		cd ${D}/usr/include/gd-1/
		for f in * ; do
			dosym gd-1/${f} /usr/include/${f}
		done
	fi
}
