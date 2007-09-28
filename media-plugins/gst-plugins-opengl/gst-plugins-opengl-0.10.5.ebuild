# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-opengl/gst-plugins-opengl-0.10.5.ebuild,v 1.2 2007/09/28 23:11:59 philantrop Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13
	media-libs/mesa"

DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="opengl"
GST_PLUGINS_BUILD_DIR="glsink"
