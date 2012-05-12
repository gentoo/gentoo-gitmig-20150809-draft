# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.30.ebuild,v 1.8 2012/05/12 18:13:58 aballier Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for OSS (Open Sound System) support"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}
	virtual/os-headers"
