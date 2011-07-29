# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-assrender/gst-plugins-assrender-0.10.22.ebuild,v 1.1 2011/07/29 07:41:42 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64"
IUSE=""
DESCRIPTION="GStreamer plugin for ASS/SSA rendering with effects support"

RDEPEND=">=media-libs/libass-0.9.4
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
