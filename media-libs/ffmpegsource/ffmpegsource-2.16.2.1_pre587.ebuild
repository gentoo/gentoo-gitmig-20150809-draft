# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ffmpegsource/ffmpegsource-2.16.2.1_pre587.ebuild,v 1.4 2012/05/05 08:02:33 jdhore Exp $

EAPI=4

inherit autotools

DESCRIPTION="An FFmpeg based source library for easy frame accurate access"
HOMEPAGE="https://code.google.com/p/ffmpegsource/"
SRC_URI="http://rion-overlay.googlecode.com/files/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="postproc static-libs"

RDEPEND="
	sys-libs/zlib
	|| ( >=media-video/ffmpeg-0.9 >=media-video/libav-0.8_pre20111116 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}/html" \
		$(use_enable postproc) \
		$(use_enable static-libs static) \
		--enable-shared
}

src_install() {
	default

	use static-libs || find "${D}" -name '*.la' -delete
}
