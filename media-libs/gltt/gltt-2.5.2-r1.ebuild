# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gltt/gltt-2.5.2-r1.ebuild,v 1.14 2004/07/21 20:19:26 mr_bones_ Exp $

DESCRIPTION="GL truetype library"
HOMEPAGE="http://gltt.sourceforge.net/"
SRC_URI="http://gltt.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="virtual/opengl
	virtual/glut
	=media-libs/freetype-1*"

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
	dodoc AUTHORS ChangeLog NEWS README
}
