# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.23.ebuild,v 1.7 2011/01/18 21:26:38 jer Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for OSS (Open Sound System) support"

KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}
	virtual/os-headers"
