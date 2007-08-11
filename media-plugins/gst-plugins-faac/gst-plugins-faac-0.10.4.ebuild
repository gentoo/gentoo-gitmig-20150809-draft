# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.4.ebuild,v 1.3 2007/08/11 03:16:03 beandog Exp $

inherit gst-plugins-bad

KEYWORDS="amd64 ~ppc ~ppc64 x86"

RDEPEND="media-libs/faac
		>=media-libs/gst-plugins-base-0.10.10.1
		>=media-libs/gstreamer-0.10.10"

DEPEND="${RDEPEND}"
