# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-schroedinger/gst-plugins-schroedinger-0.10.14.ebuild,v 1.1 2009/10/05 10:35:32 ssuominen Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.24
	>=media-libs/gst-plugins-bad-0.10.14
	>=media-libs/schroedinger-1.0.7-r2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GST_PLUGINS_BUILD="schro"
GST_PLUGINS_BUILD_DIR="schroedinger"
