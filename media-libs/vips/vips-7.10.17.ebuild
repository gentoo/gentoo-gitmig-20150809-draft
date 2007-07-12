# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.10.17.ebuild,v 1.2 2007/07/12 03:10:24 mr_bones_ Exp $

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/vips-7.10/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE="fftw imagemagick jpeg lcms png threads tiff zlib"

RDEPEND="virtual/libc
	>=dev-libs/glib-2
	>=x11-libs/pango-1.8
	lcms? ( >=media-libs/lcms-1.0.8 )
	imagemagick? ( >=media-gfx/imagemagick-5.0.0 )
	fftw? ( sci-libs/fftw )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )"

DEPEND="${RDEPEND}"

src_compile() {
	econf \
	$(use_with tiff) \
	$(use_with jpeg) \
	$(use_with fftw) \
	$(use_with zlib) \
	$(use_with lcms) \
	$(use_with png) \
	$(use_with threads) || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
}
