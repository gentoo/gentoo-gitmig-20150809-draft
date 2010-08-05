# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.22.ebuild,v 1.5 2010/08/05 20:21:59 ssuominen Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for OSS (Open Sound System) support"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}
	virtual/os-headers"
