# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.12.ebuild,v 1.6 2010/01/05 18:27:47 nixnut Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.80
	>=media-libs/gst-plugins-base-0.10.23
	>=media-libs/gstreamer-0.10.23"
