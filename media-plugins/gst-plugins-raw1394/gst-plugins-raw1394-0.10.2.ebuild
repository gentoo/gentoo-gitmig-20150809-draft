# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.10.2.ebuild,v 1.3 2006/04/08 12:46:29 dertobi123 Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="GStreamer plugin to capture firewire video"

IUSE=""
RDEPEND="sys-libs/libraw1394
	sys-libs/libavc1394"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
