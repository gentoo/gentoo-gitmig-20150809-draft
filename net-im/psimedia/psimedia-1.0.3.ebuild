# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psimedia/psimedia-1.0.3.ebuild,v 1.10 2010/11/06 19:04:49 halcy0n Exp $

EAPI="2"

inherit eutils qt4 multilib

DESCRIPTION="Psi plugin for voice/video calls"
HOMEPAGE="http://delta.affinix.com/psimedia/"
SRC_URI="http://delta.affinix.com/download/psimedia/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 x86"
IUSE="demo"

DEPEND=">=dev-libs/glib-2.18
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22
	media-libs/gst-plugins-good
	>=dev-libs/liboil-0.3
	x11-libs/qt-core
	x11-libs/qt-gui
	>=media-libs/speex-1.2_rc1"

RDEPEND="${DEPEND}
	media-plugins/gst-plugins-speex
	>=media-plugins/gst-plugins-vorbis-0.10.22
	>=media-plugins/gst-plugins-theora-0.10.22
	>=media-plugins/gst-plugins-alsa-0.10.22
	>=media-plugins/gst-plugins-ogg-0.10.22
	>=media-plugins/gst-plugins-v4l-0.10.22
	media-plugins/gst-plugins-v4l2
	media-plugins/gst-plugins-jpeg
	!<net-im/psi-0.13_rc1
"

src_prepare() {
	sed -e '/^TEMPLATE/a CONFIG += ordered' -i psimedia.pro || die
	# Don't build demo if we don't need that.
	use demo || { sed -e '/^SUBDIRS[[:space:]]*+=[[:space:]]*demo[[:space:]]*$/d;' -i psimedia.pro || die; }
}

src_configure() {
	# qconf generaged configure script...
	./configure || die
}

src_install() {
	insinto /usr/$(get_libdir)/psi/plugins
	doins gstprovider/libgstprovider.so || die

	if use demo; then
		exeinto /usr/$(get_libdir)/${PN}
		newexe demo/demo ${PN} || die

		# Create /usr/bin/psimedia
		cat <<-EOF > "demo/${PN}"
		#!/bin/bash

		export PSI_MEDIA_PLUGIN=/usr/$(get_libdir)/psi/plugins/libgstprovider.so
		/usr/$(get_libdir)/${PN}/${PN}
		EOF

		dobin demo/${PN} || die
	fi
}
