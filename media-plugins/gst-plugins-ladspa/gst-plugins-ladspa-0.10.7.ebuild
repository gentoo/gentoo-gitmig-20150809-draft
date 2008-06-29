# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.7.ebuild,v 1.1 2008/06/29 18:28:07 drac Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.19
	>=media-libs/gstreamer-0.10.19"
