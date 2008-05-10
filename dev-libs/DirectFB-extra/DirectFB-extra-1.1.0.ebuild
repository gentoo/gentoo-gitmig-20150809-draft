# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB-extra/DirectFB-extra-1.1.0.ebuild,v 1.1 2008/05/10 11:01:05 vapier Exp $

inherit eutils

DESCRIPTION="Extra image/video/font providers and graphics/input drivers for DirectFB"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://directfb.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="ffmpeg flash fusion imlib mmx mpeg quicktime svg xine zlib"

RDEPEND="~dev-libs/DirectFB-1.1.1
	ffmpeg? ( media-video/ffmpeg )
	flash? ( media-libs/libflash )
	fusion? ( dev-libs/linux-fusion )
	imlib? ( media-libs/imlib2 )
	mpeg? ( media-libs/libmpeg3 )
	quicktime? ( virtual/quicktime )
	svg? ( x11-libs/libsvg-cairo )
	xine? ( media-libs/xine-lib )
	zlib? ( sys-libs/zlib )"
#	avi? ( media-video/avifile )
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.0-CFLAGS.patch
}

src_compile() {
	#	$(use_enable avi avifile)
	econf \
		$(use_enable ffmpeg) \
		$(use_enable flash) \
		$(use_enable fusion fusionsound) \
		$(use_enable imlib imlib2) \
		$(use_enable mmx) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable quicktime openquicktime) \
		$(use_enable svg) \
		$(use_enable xine) \
		$(use_enable zlib) \
		--disable-avifile \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
