# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.8.10-r3.ebuild,v 1.5 2003/11/16 18:56:43 brad_mssw Exp $

IUSE="tcltk"

DESCRIPTION="open source graph drawing software"
SRC_URI="http://www.graphviz.org/pub/graphviz/${P}.tar.gz"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"

SLOT="0"
LICENSE="as-is | ATT"
KEYWORDS="~x86 ppc ~sparc amd64"

#Can use freetype-1.3 or 2.0, but not both
#!!!requires libpng-1.0.x!!!
DEPEND=">=sys-libs/zlib-1.1.3
	=media-libs/libpng-1.0*
	>=media-libs/jpeg-6b
	media-libs/freetype
	tcltk? ( =dev-lang/tk-8.3* )"

src_unpack() {
	unpack ${A}
	cd ${S}

	mv configure configure-orig
	sed -e "s:lpng:lpng10:" configure-orig > configure
	chmod a+x configure
	mv Config.mk Config.mk-orig
	sed -e "s:lpng:lpng10:" Config.mk-orig > Config.mk

	cd gd
	mv Makefile.orig Makefile.orig-orig
	sed -e "s:lpng:lpng10:" Makefile.orig-orig > Makefile.orig
	mv nmakefile nmakefile-orig
	sed -e "s:lpng:lpng10:" nmakefile-orig > nmakefile

	cd ../contrib
	mv Makefile Makefile-orig
	sed -e "s:lpng:lpng10:" Makefile-orig>Makefile
	cd prune
	mv Makefile Makefile-orig
	sed -e "s:lpng:lpng10:" Makefile-orig>Makefile

	cd ../../dotneato/common
	mv nmakefile nmakefile-orig
	sed -e "s:lpng:lpng10:" nmakefile-orig > nmakefile
}

src_compile() {
	local myconf
	#if no tcltk, this will generate configure warnings, but will
	#compile without tcltk support
	use tcltk || myconf="${myconf} --without-tcl --without-tk"

	#libpng-1.0 got tweaked to nicely coexist with libpng-1.2
	#need to set correct path to the .h's and libs
	econf ${myconf} \
		--with-pngincludedir=/usr/include/libpng10/ \
		--with-pnglibdir=/usr/lib/ || die "./configure failed"

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ.txt INSTALL  MINTERMS.txt \
		NEWS README

	dohtml -r .
	dodoc doc/*.pdf
}
