# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.18.ebuild,v 1.3 2005/03/13 20:34:59 luckyduck Exp $

DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${P}.tar.gz"
HOMEPAGE="http://cinepaint.sourceforge.net/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="png zlib"

DEPEND="=x11-libs/gtk+-1*
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	media-libs/tiff
	media-libs/jpeg"

src_compile(){
	econf || die
	emake || die
}

src_install(){
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING* README* NEWS
}
