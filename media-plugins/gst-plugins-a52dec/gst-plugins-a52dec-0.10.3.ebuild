# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-0.10.3.ebuild,v 1.12 2006/09/04 06:40:20 vapier Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/a52dec-0.7.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gstreamer-0.10.3"
