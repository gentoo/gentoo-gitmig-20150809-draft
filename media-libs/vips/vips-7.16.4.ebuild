# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.16.4.ebuild,v 1.1 2009/01/13 13:17:42 pva Exp $

inherit versionator

# TODO: Add video4linux support.

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif fftw imagemagick jpeg lcms openexr png python threads tiff zlib"

RDEPEND="
	>=dev-libs/glib-2
	dev-libs/liboil
	dev-libs/libxml2
	>=x11-libs/pango-1.8
	python? ( >=dev-lang/python-2.2 )
	imagemagick? ( >=media-gfx/imagemagick-5.0.0 )
	exif? ( >=media-libs/libexif-0.6 )
	fftw? ( >=sci-libs/fftw-3 )
	jpeg? ( media-libs/jpeg )
	lcms? ( >=media-libs/lcms-1.0.8 )
	openexr? ( >=media-libs/openexr-1.2.2 )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}"

src_compile() {
	econf \
		$(use_with fftw) \
		$(use_with jpeg) \
		$(use_with lcms) \
		$(use_with exif libexif) \
		$(use_with threads) \
		$(use_with imagemagick magick) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with zlib) \
		$(use_with python)

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die
}
