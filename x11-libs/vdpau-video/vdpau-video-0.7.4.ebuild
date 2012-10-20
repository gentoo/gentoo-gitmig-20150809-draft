# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vdpau-video/vdpau-video-0.7.4.ebuild,v 1.2 2012/10/20 22:07:45 aballier Exp $

EAPI="2"
inherit autotools eutils

MY_P=libva-vdpau-driver-${PV}
DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
SRC_URI="http://www.freedesktop.org/software/vaapi/releases/libva-vdpau-driver/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

RDEPEND=">=x11-libs/libva-1.1.0[X,opengl?]
	opengl? ( virtual/opengl )
	x11-libs/libvdpau"

DEPEND="${DEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-glext-missing-definition.patch"
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
