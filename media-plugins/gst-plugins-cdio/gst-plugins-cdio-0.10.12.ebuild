# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.12.ebuild,v 1.5 2009/11/29 17:35:37 klausman Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.80
	>=media-libs/gst-plugins-base-0.10.23
	>=media-libs/gstreamer-0.10.23"
