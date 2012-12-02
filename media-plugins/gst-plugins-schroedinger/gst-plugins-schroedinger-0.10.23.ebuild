# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-schroedinger/gst-plugins-schroedinger-0.10.23.ebuild,v 1.1 2012/12/02 18:03:29 eva Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/schroedinger-1.0.9"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="schro"
GST_PLUGINS_BUILD_DIR="schroedinger"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/video:gstreamer-video
}
