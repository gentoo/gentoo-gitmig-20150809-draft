# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.7.15-r2.ebuild,v 1.5 2002/08/14 11:13:49 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="open source graph drawing software"
SRC_URI="http://www.research.att.com/sw/tools/graphviz/dist/$P.tgz"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"

SLOT="0"
LICENSE="as-is | ATT"
KEYWORDS="x86 ppc"

#Can use freetype-1.3 or 2.0, but not both
DEPEND=">=sys-libs/zlib-1.1.3
	media-libs/libpng
	>=media-libs/jpeg-6b
	media-libs/freetype
	tcltk? ( =dev-lang/tk-8.3* )"

src_compile() {

	local myconf
	#if no tcltk, this will generate configure warnings, but will
	#compile without tcltk support
	use tcltk || myconf="${myconf} --without-tcl --without-tk"

	#They seem to have forgot configure when packaging 1.7.15
	./autogen.sh --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} || die

    make || die
	
}

src_install () {
   
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ.txt INSTALL  MINTERMS.txt \
		NEWS README 
	
	dohtml -r .
	dodoc doc/*.pdf
		
}
