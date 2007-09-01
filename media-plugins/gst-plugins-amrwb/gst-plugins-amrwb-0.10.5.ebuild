# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amrwb/gst-plugins-amrwb-0.10.5.ebuild,v 1.1 2007/09/01 07:07:28 drac Exp $

inherit gst-plugins-bad

KEYWORDS="~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13
	media-libs/amrwb"

DEPEND="${RDEPEND}"
