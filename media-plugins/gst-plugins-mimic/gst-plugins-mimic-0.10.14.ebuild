# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mimic/gst-plugins-mimic-0.10.14.ebuild,v 1.4 2009/10/27 15:54:38 aballier Exp $

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for the MIMIC codec"

KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.24
	>=media-libs/gst-plugins-base-0.10.24
	>=media-libs/libmimic-1.0.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
