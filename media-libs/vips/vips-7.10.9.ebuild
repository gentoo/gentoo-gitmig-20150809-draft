# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vips/vips-7.10.9.ebuild,v 1.4 2005/04/07 19:18:32 swegener Exp $

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/vips-7.10/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

SLOT="1"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"

IUSE="tiff png zlib fftw lcms jpeg imagemagick threads"

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
	local myconf
	use tiff    || myconf="--without-tiff"
	use jpeg    || myconf="${myconf} --without-jpeg"
	use fftw    || myconf="${myconf} --without-fftw"
	use zlib    || myconf="${myconf} --without-zip"
	use lcms    || myconf="${myconf} --without-lcms"
	use png     || myconf="${myconf} --without-png"
	use threads || myconf="${myconf} --without-threads"

	econf ${myconf} || die

	emake || die
}


src_install() {
	emake install DESTDIR=${D} || die
}
