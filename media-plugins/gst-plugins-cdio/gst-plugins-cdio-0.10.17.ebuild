# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.17.ebuild,v 1.4 2011/07/25 18:07:12 xarthisius Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.80
	>=media-libs/gst-plugins-base-0.10.26
	>=media-libs/gstreamer-0.10.26"
DEPEND="${RDEPEND}"
