# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.7.ebuild,v 1.3 2008/07/30 13:30:03 ranger Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/faad2-2
	>=media-libs/gst-plugins-base-0.10.19
	>=media-libs/gstreamer-0.10.19"
