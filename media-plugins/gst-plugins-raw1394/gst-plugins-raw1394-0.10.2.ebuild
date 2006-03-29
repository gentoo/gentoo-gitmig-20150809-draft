# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.10.2.ebuild,v 1.2 2006/03/29 18:14:18 corsair Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc64 ~x86"

DESCRIPTION="GStreamer plugin to capture firewire video"

IUSE=""
RDEPEND="sys-libs/libraw1394
	sys-libs/libavc1394"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
