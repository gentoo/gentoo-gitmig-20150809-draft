# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gltt/gltt-2.5.2-r1.ebuild,v 1.11 2004/03/19 07:56:03 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL truetype library"
SRC_URI="http://gltt.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gltt.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/opengl
	virtual/glut
	=media-libs/freetype-1*"

RDEPEND="$DEPEND"

src_compile() {

	#small gcc3.x fix for #9173
	cp FTGlyphVectorizer.h FTGlyphVectorizer.h.old
	sed -e 's:friend FTGlyphVectorizer:friend struct FTGlyphVectorizer:' \
		FTGlyphVectorizer.h.old > FTGlyphVectorizer.h

	./configure \
		--with-x \
		--prefix=/usr \
		--with-ttf-dir=/usr || die

	make || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README

}
