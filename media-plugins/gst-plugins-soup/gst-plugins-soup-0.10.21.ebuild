# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.21.ebuild,v 1.6 2010/07/24 15:09:22 maekke Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.27
	>=media-libs/gst-plugins-base-0.10.27
	>=net-libs/libsoup-2.26"
DEPEND="${RDEPEND}"
