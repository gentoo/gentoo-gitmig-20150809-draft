# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.4.ebuild,v 1.3 2007/07/26 14:09:55 gustavoz Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"

RDEPEND=">=media-libs/faad2-2
		>=media-libs/gst-plugins-base-0.10.10.1
		>=media-libs/gstreamer-0.10.10"

DEPEND="${RDEPEND}"
