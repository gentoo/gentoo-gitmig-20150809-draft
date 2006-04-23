# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-x/gst-plugins-x-0.10.4.ebuild,v 1.8 2006/04/23 22:44:58 compnerd Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 ~sparc x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.4-r1
	 || ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

# xshm is a compile time option of ximage
GST_PLUGINS_BUILD="x xshm"
GST_PLUGINS_BUILD_DIR="ximage"
