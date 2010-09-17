# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vdpau-video/vdpau-video-0.6.10.ebuild,v 1.2 2010/09/17 09:41:58 fauli Exp $

EAPI="2"
inherit eutils autotools

DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
SRC_URI="http://www.splitted-desktop.com/~gbeauchesne/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug opengl"

RDEPEND="x11-libs/libva[opengl?]
	opengl? ( virtual/opengl )
	x11-libs/libvdpau"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable opengl glx)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS
	find "${D}" -name '*.la' -delete
}
