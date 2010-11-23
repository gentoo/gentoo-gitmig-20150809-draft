# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.22.4.ebuild,v 1.4 2010/11/23 20:38:29 jer Exp $

EAPI=2
PYTHON_DEPEND="python? 2"
inherit eutils versionator python

# TODO:
# matio? ( sci-libs/matio ) - in sunrise
# cimg support?

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE="exif fftw imagemagick jpeg lcms openexr png python static-libs tiff v4l"

RDEPEND=">=dev-libs/glib-2.6:2
	>=dev-libs/liboil-0.3
	dev-libs/libxml2
	sys-libs/zlib
	>=x11-libs/pango-1.8
	fftw? ( sci-libs/fftw:3.0 )
	imagemagick? ( || ( >=media-gfx/imagemagick-5.0.0
		media-gfx/graphicsmagick[imagemagick] ) )
	lcms? ( =media-libs/lcms-1* >=media-libs/lcms-1.0.8 )
	openexr? ( >=media-libs/openexr-1.2.2 )
	exif? ( >=media-libs/libexif-0.6 )
	tiff? ( media-libs/tiff )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

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
		$(use_with v4l) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die

	# 314101
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${PF} || die
	rmdir "${D}"/usr/share/doc/${PN}/ || die
	dosym /usr/share/doc/${PF} /usr/share/doc/${PN}

	find "${D}" -name '*.la' -exec rm -f {} +
}
