# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.0.ebuild,v 1.2 2006/04/04 15:04:40 mr_bones_ Exp $

inherit gst-plugins-bad

KEYWORDS="~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.0
	 >=media-libs/libmms-0.2"

DEPEND="${RDEPEND}"
