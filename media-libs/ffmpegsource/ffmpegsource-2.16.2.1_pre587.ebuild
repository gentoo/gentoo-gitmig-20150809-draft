# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ffmpegsource/ffmpegsource-2.16.2.1_pre587.ebuild,v 1.1 2011/12/05 09:47:00 maksbotan Exp $

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
	virtual/ffmpeg
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
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
