# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.10.ebuild,v 1.2 2009/02/05 21:35:08 aballier Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.80
	>=media-libs/gst-plugins-base-0.10.21
	>=media-libs/gstreamer-0.10.21"
