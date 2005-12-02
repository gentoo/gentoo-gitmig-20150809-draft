# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.9.7.ebuild,v 1.1 2005/12/02 22:35:42 zaheerm Exp $

inherit gst-plugins-good

KEYWORDS="~x86 ~amd64"

GST_PLUGINS_BUILD="libdv"
DESCRIPTION="GStreamer plugin to decode DV"

IUSE=""
RDEPEND=">=media-libs/libdv-0.100"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
