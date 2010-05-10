# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gl/gst-plugins-gl-0.10.1.ebuild,v 1.2 2010/05/10 16:27:24 ssuominen Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="GStreamer OpenGL plugins"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND=">=dev-libs/liboil-0.3.8
	media-libs/mesa
	>=media-libs/glew-1.4
	>=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.15.1
	>=media-libs/gst-plugins-base-0.10.15.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch
	# avoid autoreconf for no good reason
	sed -i \
		-e 's:libpng12:libpng:' \
		configure || die
}

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--disable-examples \
		--disable-valgrind \
		--with-package-origin="http://packages.gentoo.org/package/media-plugins/gst-plugins-gl"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README RELEASE TODO
	find "${D}"usr/$(get_libdir) -name '*.la' -delete
}
