# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit gst-plugins-bad

KEYWORDS="~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.0
	 >=media-libs/libmms-0.2"

DEPEND="${RDEPEND}"
