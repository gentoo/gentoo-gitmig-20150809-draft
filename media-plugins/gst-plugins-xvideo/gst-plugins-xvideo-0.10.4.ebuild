# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.10.4.ebuild,v 1.3 2006/03/16 23:23:16 corsair Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc64 ~x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.4
		 || ( x11-libs/libXv virtual/x11 )"
DEPEND="${RDEPEND}"

# xshm is a compile time option of xvideo
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"
