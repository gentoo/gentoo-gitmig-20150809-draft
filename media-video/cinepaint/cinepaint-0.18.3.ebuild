# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.18.3.ebuild,v 1.1 2004/08/03 09:07:09 dholm Exp $

inherit eutils

MY_PV=0.18-3
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://cinepaint.sourceforge.net/"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
IUSE="png zlib"

DEPEND="=x11-libs/gtk+-1*
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	media-libs/openexr
	media-libs/tiff
	media-libs/jpeg"

src_compile(){
	econf --with-openexr-prefix=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	einstall DESTDIR=${D} || die "einstall failed"
	dodoc AUTHORS ChangeLog COPYING* README* NEWS
}
