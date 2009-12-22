# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.20.6.ebuild,v 1.1 2009/12/22 11:03:45 pva Exp $

EAPI=2

inherit versionator

# TODO:
# matio? ( sci-libs/matio ) - in sunrise
# cimg support?

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif fftw imagemagick jpeg lcms openexr png python tiff v4l"

RDEPEND="
	>=dev-libs/glib-2.6:2
	>=dev-libs/liboil-0.3
	dev-libs/libxml2
	sys-libs/zlib
	>=x11-libs/pango-1.8
	fftw? ( sci-libs/fftw:3.0 )
	imagemagick? ( >=media-gfx/imagemagick-5.0.0 )
	lcms? ( >=media-libs/lcms-1.0.8 )
	openexr? ( >=media-libs/openexr-1.2.2 )
	python? ( >=dev-lang/python-2.2 )
	exif? ( >=media-libs/libexif-0.6 )
	tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am"

src_configure() {
	econf \
		$(use_with fftw fftw3) \
		$(use_with lcms) \
		$(use_with openexr OpenEXR) \
		$(use_with exif libexif) \
		$(use_with imagemagick magick) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with jpeg) \
		$(use_with python) \
		$(use_with v4l)
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die
}
