# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.9.ebuild,v 1.6 2003/05/05 14:16:52 lu_zero Exp $

IUSE="tcltk"

DESCRIPTION="open source graph drawing software"
SRC_URI="http://www.graphviz.org/pub/graphviz/${P}.tar.gz"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"

SLOT="0"
LICENSE="as-is | ATT"
KEYWORDS="x86 ppc sparc"

#Can use freetype-1.3 or 2.0, but not both
DEPEND=">=sys-libs/zlib-1.1.3
	>=sys-devel/gcc-3.2*
	>=media-libs/libpng-1.2*
	>=media-libs/jpeg-6b
	media-libs/freetype
	tcltk? ( >=dev-lang/tk-8.3* )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myconf
	#if no tcltk, this will generate configure warnings, but will
	#compile without tcltk support
	use tcltk || myconf="${myconf} --without-tcl --without-tk"

	econf ${myconf}

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ.txt INSTALL  MINTERMS.txt \
		NEWS README

	dohtml -r .
	dodoc doc/*.pdf
}
