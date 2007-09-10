# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.5.ebuild,v 1.3 2007/09/10 16:43:19 nixnut Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND=">=media-libs/faad2-2
	>=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13"

DEPEND="${RDEPEND}"
