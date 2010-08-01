# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gstreamermm/gstreamermm-0.10.7.3.ebuild,v 1.3 2010/08/01 10:59:29 fauli Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="C++ interface for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/bindings/cplusplus.html"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# gstreamer 0.10.25 is needed for per-stream volume
# see bug #308935
RDEPEND="
	>=media-libs/gstreamer-0.10.28
	>=media-libs/gst-plugins-base-0.10.28
	>=dev-cpp/glibmm-2.21.1
	>=dev-cpp/libxmlpp-2.14
	>=dev-libs/libsigc++-2:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_test() {
	# explicitly allow parallel make of tests: they are not built in
	# src_compile() and indeed we'd slow down tremendously to run this
	# serially.
	emake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" libdocdir=/usr/share/doc/${PF} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README || die

	find "${D}" -name '*.la' -delete || die "removal of *.la files failed"
}
