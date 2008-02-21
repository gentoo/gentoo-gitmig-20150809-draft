# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.10.7.ebuild,v 1.1 2008/02/21 14:47:53 zaheerm Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="GStreamer plugin to capture firewire video"

IUSE=""

RDEPEND="media-libs/libiec61883
	sys-libs/libraw1394
	sys-libs/libavc1394
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
