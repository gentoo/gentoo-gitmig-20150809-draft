# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.12.5.ebuild,v 1.1 2007/12/10 15:51:42 maekke Exp $

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/vips-7.12/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE="exif fftw imagemagick jpeg lcms openexr png threads tiff zlib"

RDEPEND="virtual/libc
	>=dev-libs/glib-2
	>=x11-libs/pango-1.8
	dev-libs/liboil
	dev-libs/libxml2
	lcms? ( >=media-libs/lcms-1.0.8 )
	imagemagick? ( >=media-gfx/imagemagick-5.0.0 )
	fftw? ( >=sci-libs/fftw-3 )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	openexr? ( >=media-libs/openexr-1.2.2 )
	exif? ( >=media-libs/libexif-0.6 )"

DEPEND="${RDEPEND}"

src_compile() {
	econf \
		$(use_with tiff) \
		$(use_with jpeg) \
		$(use_with fftw) \
		$(use_with zlib) \
		$(use_with lcms) \
		$(use_with png) \
		$(use_with threads) || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
