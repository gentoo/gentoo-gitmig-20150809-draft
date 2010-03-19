# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.13.ebuild,v 1.3 2010/03/19 09:36:30 pacho Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.80
	>=media-libs/gst-plugins-base-0.10.25
	>=media-libs/gstreamer-0.10.25"
DEPEND="${RDEPEND}"
