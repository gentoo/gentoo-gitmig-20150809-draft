# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-colorspace/gst-plugins-colorspace-0.6.3.ebuild,v 1.2 2003/09/14 00:04:45 dholm Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND="media-libs/hermes"

BUILD_GST_PLUGINS="colorspace"
GST_PLUGINS_BUILD_DIR="hermes"
