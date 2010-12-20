# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.10.23.ebuild,v 1.3 2010/12/20 17:26:17 hwoarang Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to capture firewire video"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="media-libs/libiec61883
	sys-libs/libraw1394
	sys-libs/libavc1394
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
