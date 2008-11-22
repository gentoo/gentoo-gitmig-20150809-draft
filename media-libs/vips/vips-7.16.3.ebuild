# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.16.3.ebuild,v 1.1 2008/11/22 23:25:30 maekke Exp $

inherit versionator

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif fftw imagemagick jpeg lcms openexr png threads tiff zlib"

RDEPEND="
	>=dev-libs/glib-2
	dev-libs/liboil
	dev-libs/libxml2
	virtual/libc
	>=x11-libs/pango-1.8
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
		$(use_with png) \
		$(use_with threads) \
		$(use_with tiff) \
		$(use_with zlib)

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
