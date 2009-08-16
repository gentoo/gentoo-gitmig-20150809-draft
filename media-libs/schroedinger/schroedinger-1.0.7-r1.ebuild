# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-1.0.7-r1.ebuild,v 1.1 2009/08/16 12:49:50 ssuominen Exp $

EAPI=2
inherit eutils libtool

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://www.diracvideo.org"
SRC_URI="http://www.diracvideo.org/download/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gstreamer"

RDEPEND=">=dev-libs/liboil-0.3.16
	gstreamer? ( >=media-libs/gstreamer-0.10.24
		>=media-libs/gst-plugins-base-0.10.24 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gst_adapter_masked_scan_uint32.patch
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		$(use_enable gstreamer)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS TODO
}
